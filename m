Return-Path: <dmaengine+bounces-10027-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A7sxFmLB5WmAnwEAu9opvQ
	(envelope-from <dmaengine+bounces-10027-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:02:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC3426FEC
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23648300C5B0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC19377EDB;
	Mon, 20 Apr 2026 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k7N2ROFY"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77F214204;
	Mon, 20 Apr 2026 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664927; cv=fail; b=PKO408cQUcpkjU68iNAu/maK7f+xa4efbcIdNsNhsxUxotUilSJaCy9VQhR4uT1QazLm54dm8kytSZiVCP84DF6tWUgNzRhFPhmKhVEBTjUddD+wj1ysytMYh+V2gGhO6gqiLK6HmK+CYL9dpF0BP0jXfv/qL46KClaEymNhpqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664927; c=relaxed/simple;
	bh=N6VGviKLU+7HgFVBKGzgNUNRJwQW/Fb4oyxul//mxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hoeotzv/b/aS52VhpW03QGQnd1VlRmOnpdzhxwoYEGqwG7LGR5GgWiI5Fc53Lsy7dIP6jlQsC6fqB7XeGKBKgmjdE/v7PaAdMGAeNRyHuTIaS/xJiiXtrVl0FrsOoMwQyNc6J7xjhukAAnLxw/FV8HutHg6huV6b4QyFMj2Y4bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k7N2ROFY; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlkOZ6SvnN8TTsFNr0L/hrsXqNwT1FFeaJov2UrvZ74Tocbiw5/Sdfue+AH8X+v9spaK76kdIqqGOR0Yp7YURnVI2rXbEjS8b1ORhSC0xH00gvEh0Nw0cgPqwRbnwKguB4V0U9deJsCqmI6CGh+apt72mnvPi/F0xkfTXIfGCkxXwK3Xlwe3vB5qdVwmfkw/eYbS6bkaxQ38WyDOtKc1bfhLq1RGac6NchgnDT4/asN/kJg15i259uhsXRHIZmp2gRYMi5kINZSddM/MkVC4GjzPMMBO1SwxUb0QxDyTu95oT02v/1GzSxy1efbIU9qfrOkqUvgqq6jqXmDVimMUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTrwLvVovUIj36IXUInpySLg+6Ln4i3QRgtfYxbdQ5g=;
 b=VLDSmL0vq1x/y+fIwxw8PhKTp/UzfZM8J4PQcSsmjEZnkSz1UXgRA5gTruLxDfC5iJL3ETAUb9+5FLaZwSBry/0VoGXLydQUyQUa4zPxivCWUNo+4DpwJjDrFQ8DahStHp5z8PQk1EhJk5K8ISgtXrba7sjK2rlwk2cekyfRctapalYGyd0qq1hsErUegmFSZg8ntwvPd6P7h3uFUPclAbIxcvGUmX+0yfjKmcuCIiFM+1X/gjJqoDrKF9dbBRLJAtqLfgXQDxTe6QVNC6+k0CNSnCAOv3erUNqOWVSx+xIahmo/GFfrkkom3qzaWegP624r5wUN7n42xksX4bMBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTrwLvVovUIj36IXUInpySLg+6Ln4i3QRgtfYxbdQ5g=;
 b=k7N2ROFYwqa7ly6r4en1b2NPa8uOsJrcoadWK70q6B92K5bvGBAI1Sb/2igMqt07oPV0/8W+DNTwbNdp19fa80PSMFTDd4/xh4l7frGd3AItR67x7gVCMJjdw+bNx6SZuLuMnm9j4i7vXb6fD0rOGsEKfE7KzeyTVWBzqVb5jiStdwDyiFUWtep70dlQVakUQC4eLlOqCBNDDn0KmZOUYYtc++WSkoQKEwlaB/XBoAaLXzEuUmffYIm/K1Bx0C8oAwMqNApXUzLfPjqMfSbq77Rrv3jA2MA6QsxsFiUDAV2gKroRTbm7Qi06xrxuDqBl5G2AjCO72NStncMHFYabCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11310.eurprd04.prod.outlook.com (2603:10a6:102:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 06:02:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:02:02 +0000
Date: Mon, 20 Apr 2026 02:01:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idxd: fix deadlock and double free in
 idxd_cdev_open()
Message-ID: <aeXBVKLvHANxqGGZ@lizhi-Precision-Tower-5810>
References: <20260416221957.51250-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416221957.51250-1-dbgh9129@gmail.com>
X-ClientProxiedBy: SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11310:EE_
X-MS-Office365-Filtering-Correlation-Id: 7355f4ee-025c-456d-1591-08de9ea25795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tzYpt0Qd8BRBtVuNZJalUx3Qi/l76if5zBOR/afOe93L51BtJy6ovf0+8KcyT96Ly68pF2u0zrL0lOG4RxJtcNHLetfzZ09exmOIy/+LiggACZSKmlfi7BIgU7nTlliDNmCYEeaVbevjkHc2qiXd0RK4FN7QmQDhhPyM2IJmpsN932RXDDcpFYNBINSTijeLzfhIJJXHOAwq/hTXkz+vYaISPHaiz3vXJAmCuN+Hh4gu54deb2YPMdqDvcFpfB5dy0uQbCBA7A1RiAxIq7RruDuYz9eaFtBm68koSRloBlERxR0qiZmMwdQvSbSkZtFvHBhFfbiJmEsm3eF20XnlTDaN1HBDIb7w3fIQ8Oq/eelRpPbELLtPti54q8uDHZgnkffDdbg0HcXSy+YPRW+a1ZJL69EBLaoi4HefUZj4LYxfwrYFXxZd0YFACP9js7StxhU+2mt7Ns11U1R7rPMf3JMGhhCmMgVCJc6Q6/eTBDGV0UJEkoXMUDbXCIdZz0RU8R8vpWOma+mmHb1vZmncBiTMr/uXd/2QIx6ehRyGgQcY8A7lNJFR2PKC8KekqkulGq7jqMyNLQm3/4i/jwR6XTcJWc2bJAxw1wFxL+OprZeBaEuh1eSDDQlZ1dNMifqDFAfYf+FeUu51LPEGOfFYvvnuADIu4+g5rIHvPKv0wM6ax/00ESoVWzx4n95kfCWNTD4Wv1J5+gBJ6buhR4iwYqxCPkg1GvT6IN6gJM4cSnJgLk3lVhhvoUPLI8+GGi+hripAZzMphxPtnTlUoU0UvaYYmT4qnTftdz44FjQdH2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNoSUM5UXNQWjFmcEdBaHFxWTJJZ09FN3NXZGpkOUd0K1JYeDRkOTlPYkJx?=
 =?utf-8?B?U1hld2kzU2huUUh6Y1FJdjVqaWVYZDUxTE1ONXk0SmVuUDFkNHpWNlRITmVV?=
 =?utf-8?B?dzdjcCtIb3RLdm5oZmtrNmd4dmZBOW4rWHphbjJFb01Hd1ZSMnp3Vnp3alpn?=
 =?utf-8?B?bmxaMHl3VTNLKzR6VGlTWk52SFFWN3hNU0NoUHRQOFNnUFpWcUZrSzY5SnBS?=
 =?utf-8?B?TmlUNjdDT2tBekl4eFp3S3RpbEZRa0kxazZBT0VIQWxmaS9Bb3NLT2dyQjRR?=
 =?utf-8?B?ZWtYVUU0S2Z2bGJIakxWVEdjN2g1TWN6WDMxTFQ1czBmKzlvMU53RVlKbzFU?=
 =?utf-8?B?bnVTT3VIWWhNWU8vZmI3MEY2WlJ0RzI5UlNIQmlibVdHRCs1aUZuK3pWbXhT?=
 =?utf-8?B?MGRzaCtMZmVmWWtIZUVqL2VFOU15Rk1MbVkyZWtiQmJpTkttb0ZwdXRRa2Ny?=
 =?utf-8?B?MmVkdElNaFpSd052eWRHSTZUT0hja2ZRc1o0K0NvazRvemZEc09MRnpNUklQ?=
 =?utf-8?B?VVppZ0UzdGlnL21CUFVKSUV4bC9CeUR5bUFkVUljekNXWG5zQUZOUnF1Qi9N?=
 =?utf-8?B?Y0x3dWdHdHpEMmlCL1RaS2ZBTnJSVjBBOG5tQVFzWDNhKzl2cHduQVhEVUd3?=
 =?utf-8?B?T25PS2pEVEJkeXdyK2hvWm9pMTlEZTRXOCtWWDZ1ZU93ekI3UEVxdnBCeTl3?=
 =?utf-8?B?VUIvQitES2dZanFLbkZ4NHBxM3ZuUlhhU0tMb0hmTmRGUWRzVXNKN1JIbXRu?=
 =?utf-8?B?NTJqcHVUTlh2S3Z5cWRZTzJ3UDZJYWp4Q2hSMzk0TXBUN3pwcGMwb0tPNXly?=
 =?utf-8?B?TDNOUGh3aWowdzBKQTd3NVFueWdpQ04xMjNrK0xIRXREczVrU1NzRGVGNkZw?=
 =?utf-8?B?c2NiUXBQRExMV1JjSUlVLzE0ajhzcU9hSWhmM2dsbGN4OU85anZyU1RwbG1l?=
 =?utf-8?B?MDhBTzg4YlRTS0ZVSkVuRnAzbWhzODZST0tpcXNxVnFYVXlqWDJXWGJ4eFVJ?=
 =?utf-8?B?aTJaY0szYUZ5cElMZk1mZHkwNWFYNGVMOGNqSjR2RjRwZFM3bkJDcy9DRUt3?=
 =?utf-8?B?NVpSUDc1OW1paEtUVWdMZytQNkNQUTdCMWNIWUxPVDIwN0I2dEtIT3g0eEkv?=
 =?utf-8?B?R1NXVC8wdnhEa3B6aTFtbGdDbGxQM1lRSFVNN1dVeGFhSm45K29RdnJETU5j?=
 =?utf-8?B?T1JRTW5lYnlZWml5YjZqZGhNZk1QSXl3dFd3ZEdpanJqb2lWUUtEcEd0WVMx?=
 =?utf-8?B?emFuY1crUVYrWmtZTUduTkphQ0VPNnNaZ0xpQzNvOTVpSmljcnR6QzVnQlIr?=
 =?utf-8?B?NDA1UUtaR01BSmdJeWVDV29zMkViYWUrTFlDaXVBMzNzR3lDNWNobFNrT2JE?=
 =?utf-8?B?OWJTZGp1dDRKSUZNNUpDTytoSm1iUHZhdWtZUFllK01pV2NSS0ttTkZFSjgw?=
 =?utf-8?B?Y3hZY2hmYmJMa1EzWis2WmRGZEVMSjNibU1IcldTbEZDaHRRbnFmQUVTSTE1?=
 =?utf-8?B?L2dwTnR5cllxRm1wYThodUhHZncwcm56SkR0MTVoNmtWM0RVR1ZZbFBvSS9L?=
 =?utf-8?B?TlNPeU9mcWIyTU41SGJKeTQ4MFlFVmlROHZJbjBRU3ErRk5nSDJ0UDdQRjFE?=
 =?utf-8?B?QVpJUWVIV2R2OVNDNzVRUzZ6bGxvMnVEMDk2ZTY5ZllTOU5CNFF4RTdZTmV0?=
 =?utf-8?B?cXphZ3FyV1djSkQ5bjRObWNhb3NPR3EyUkpPaUowK0p5d0ZObEV4MGc5a0I5?=
 =?utf-8?B?R2dpKzZnVFhrczV2YmsxQVZqaVFtMHROeDY3Y1BZRTg4OUE4ejB3Um05U2Z3?=
 =?utf-8?B?N1JnV2p2a2tKdTUzNmc5NGdIVko4REgzTDFWWllpb1ZzUmUzQWR0VGg0b1RJ?=
 =?utf-8?B?dWpxWTB4enRobmlrbGlUbGVuUVJrSjRSdWVrN2x6ZEVBTlNscE41TlExRmVn?=
 =?utf-8?B?cS80L2R3WUQrQlZiODRzOXNjOU9iMXZHbTByNFN6a2kwckJEcllwWWM5TWJB?=
 =?utf-8?B?eW9xYjJPeXRIajJEVWNwWmh6UVBQYXQxd0pPSzN2cEJ6WlE3VFNac1AxOHJM?=
 =?utf-8?B?ZmF1YjlZK1BKRitFNXNjY2FYUnI3VFFrUDhaSU9PYTVTbGVRaFhkeGJHb0Vx?=
 =?utf-8?B?aTZBbGF5dDRJTDJSbXVxVmQwdlc5VnVPMnpETUJwRXJFMjAyOVZualpCcnl0?=
 =?utf-8?B?WllIdmlleDZEK1pndGVLRkQ4L24xdTl1M25CcUZVN04xNTdXdFpZS3o2dzBp?=
 =?utf-8?B?V1ZpWVk1T3QxbUticUNFQURYdkZxOEdvekk3aFYrOXU2QURiamVWNEdNb1Q5?=
 =?utf-8?Q?2ZdjwZ3RzjsF9XQJH9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7355f4ee-025c-456d-1591-08de9ea25795
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:02:02.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTSNiDco1ZDwP5OcIHTzO1e0JiD/RRpvNa63gpcvNBH8p8bL3q0JIvKuu87PNgAHXa74dKdqKaL1OX6Udt+ccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11310
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10027-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C9AC3426FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 06:19:57PM -0400, Yuho Choi wrote:
> The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
> call put_device(fdev) while still holding wq->wq_lock. This triggers
> idxd_file_dev_release() synchronously, which calls
> mutex_lock(&wq->wq_lock) — deadlocking on the same mutex.
>
> Additionally, the original code fell through from failed_dev_add and
> failed_dev_name to the failed: label, which called kfree(ctx) a second
> time after idxd_file_dev_release() had already freed it. The subsequent
> idxd_xa_pasid_remove(ctx) then uses the freed pointer.
>
> Fix both issues by releasing wq_lock before put_device(fdev) and
> returning immediately, so the release callback acquires the lock without
> contention and no further cleanup is attempted on the freed context.
>
> Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/dma/idxd/cdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0366c7cf35020..19a449333782b 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -307,7 +307,9 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>
>  failed_dev_add:
>  failed_dev_name:
> +	mutex_unlock(&wq->wq_lock);

Can you use auto cleanup to fix this problem?

Frank

>  	put_device(fdev);
> +	return rc;
>  failed_ida:
>  failed_set_pasid:
>  	if (device_user_pasid_enabled(idxd))
> --
> 2.50.1 (Apple Git-155)
>

