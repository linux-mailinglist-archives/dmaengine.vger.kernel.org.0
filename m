Return-Path: <dmaengine+bounces-8918-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJacLteZlGkoFwIAu9opvQ
	(envelope-from <dmaengine+bounces-8918-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:39:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADD14E537
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F36D304A6D9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96F334C31;
	Tue, 17 Feb 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJJi4Qhl"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80436EABC;
	Tue, 17 Feb 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346363; cv=fail; b=fdJQ1mVVD5ebrC/1XBO0rzYtGUi/V5LladpfYsLPMF6HVCUznuvWrNxu69Qx81MtYQ02v3p7a97UiBaZg9XEtvvnEdc75hZwHmG69H52bnIrgtZ0jLTO3G8cNpjL/6HzsWGqIhlQ6N8zK4fHPsNMoqQ386x+ecKAATQSAwKUEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346363; c=relaxed/simple;
	bh=FO+aIoIiErFQl2coY+wf0YrmpanfzivqVHCYvhrXHtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtDUFNki0KOZUreeHzjy+83X6ZWoPMdCMF7ZOTBjm5vWoA9/uDQOrZ/3gpHo5idhbq6H2wf8CbOJJ5k9uAhDnzz3IgIDGZovHr8YudsFi7iQNb3qAYRs+iXH3K5PuzBQDQPC5s1PdrEWhk4wCkKkW13EoEc88ksi+rc8dTNvAH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RJJi4Qhl; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiA7Hbmng9W/Md+Na0BsxEwdje466/VVa3S6qQBCIFV233rVSm6xoIXSOwBKFwUqIx0kheQFfwFysYY63uNr167r+qWc3SPmEkrS0k9+SATRS7C3d553yDHthBE/GQjlDRg7+kqgRVcZFVoi5u/mEFChIBCwm78lrN4mg4H+QA7sCYrtckqWJQ76Y4wqtLvAIE6Wb3at0rdDduALwLgNg98+vbtiIBUF78hlXGeDR1+2x3J/1FDQf14zBqM8ttBPB73RwyrRCGh9rBEOilre39nU7SzDP+sP3tfmiiJ9KdwrIHeYwgkJQUmf6yDStD3OtsUa9PwMF3t1XJOSxvTjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2Y+w5F3/sUeBGQ1JjT+vKaAdpmrMmlZzScABAU0Q6E=;
 b=MZny5U+OgxHj3vvngXVgDqhO+r3BXDsOiqjOejkNGZu5tXsuhI+U9tQY9kZRkiTrS6A7B49rj/iZ3Qzp8mf99hUH6lcP+ZmNU4fedD4PcBI0mcOxY7+SR6eaE+vACTqlRCnnJ7Ah++omE2JeyFs/nqwE/AjjFVGuuEisbzwk2/ffe24UPOhp6d9Qz6pkKOl6CkOM0SyiODS71EUrCsEMEtWU2Gtl4xAwh8RLG4Tk9oOHO3UoRkqh6oanyBzm5Yzp45eqKovsRLx9a6diXOuGWsBJy/yB7mrRiZtNJLBy/fB+1t42yzMK/iT7OCC0aNLTQ8H/wq7CmBAKhIjBLR0+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Y+w5F3/sUeBGQ1JjT+vKaAdpmrMmlZzScABAU0Q6E=;
 b=RJJi4QhlE76mK9iAErmrRxOT+d+OmA4F6vRkKOnRcT+nhTwcashkp4alkMzZelFelYEy7MRq7ihYE7ayjXxqvxtzfv1bfexC1LLeuKcmIBpKyxYJgXWUrr1RCW3trIp2T71Qv5pyt9hTgda+M20KRm1+0ZaOvpBrt4o4VOkd5e1uhvRomsByTt0wW4W6PxXJ3SUiKKOJMUd5AcxvfLs6Ui1/5yORzupIJ9wBq6lnG/sb05Se9wlwKs2x0Mw3V8STncTMoryrJQ0CO94mXwXb2p5lY92GYBodb8KPbVX5/djBa6gSlHsilxJ9+K8wysa44wMgwJ4GQQ6GF7bl98EQKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 16:39:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:39:16 +0000
Date: Tue, 17 Feb 2026 11:39:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 844bdfc0-5ea8-4691-9410-08de6e431729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4mRbzR1ssKMKL610DtRwJzBZpqb/uP2ySBZPqdcaE+0ZFAdKHzucT/sAsO0Z?=
 =?us-ascii?Q?YMDVeH1a5tMf8mFf3UtYvtCmt9keZNF23DAu6aKovsPljj15BLVfGZ4Z/Z9z?=
 =?us-ascii?Q?UtRfWFH1C2LuMMel+DMG17peCwbLi9tMY10so+tOd72zBPwbzqiH5qdnPwmv?=
 =?us-ascii?Q?PfO4C4HNzD5CtBpYvtiGp3II8M127kINKCyFKAy4oprXBSDjKQblHOtJGwpu?=
 =?us-ascii?Q?altB//hJM8asnfZkQVtE5TR5p7B1rBTxAOHfMxqvnePz/7N7tZ1Ca9L3ZJ/X?=
 =?us-ascii?Q?bS+HuCAAcDCuS7nEdeX8NSI7fz8HtpOKB7MZwY+iBMQkOCvfS/sbNyXP6zwE?=
 =?us-ascii?Q?IwHdFD2RGVOo1ogUSFHsKzYgI23cpTsV+4bceRXfQ6gRq1sVRaTZ/ulvQ5Wm?=
 =?us-ascii?Q?qYIkwBp8SqNRzcWp+WTGLxjgfAJeb/rNCrLPc7gGoZSreHq001l9dXiXuXou?=
 =?us-ascii?Q?VOeSAmizoN+fQhXigqhQif+6HHkBYJIIO4WWPHTUZvymFa4RZk/9dzR78m5H?=
 =?us-ascii?Q?SiRsbZ5XZQ89y+aUaGMWaTc0fZxzMcxjbuFPybNDjkdwdWI+17tt3lNhlLRM?=
 =?us-ascii?Q?qk+YeZSIIZEWs2jdMM09Q2ygxTI1p1gwUjGJWSPMAHe5Uz7YFCdI8eqbu3Ln?=
 =?us-ascii?Q?d5FgmnaiE7BIevE0l54m7S2NhgWlsuwXkLka4wyhjkPGLwniZBUEud8n5wIT?=
 =?us-ascii?Q?FhdojUtbUp92PwoLf9EsT8BNPMF/xm/sQ0qAYrL/1zpzaR9wGnGHJ39L9dE7?=
 =?us-ascii?Q?2zelk0Gv6nyCDRDCipr+8B6nSdixlGkP+SprnXZYEW9DDsrUqo/Q9UPamOAi?=
 =?us-ascii?Q?Qdbl8p3Wyu8Lobz4VNA6CTQVaHIsBOktSyfbZnyLb+UqO2qs/FOfWz+Zt5sr?=
 =?us-ascii?Q?4DCPwOVqyq4+gX4Oe1GGTwzmPo5oDWtE1klTAnbvr7cUmG1LpI6jTuTvUVbH?=
 =?us-ascii?Q?dsuCISEMVfYjqZEnn4y+G1gUEbBFHkZ5SXL8xbhXcc1MN94tC/gUu20Sd1pN?=
 =?us-ascii?Q?jDZpzbK/Kv1J0yqOD9LkXeaJKnboow9aOQS9Me9hEyuzBafCwWuAxIqa1b3p?=
 =?us-ascii?Q?ebio83hcgPNfxDojTystqJ2KrKqOUtg5fWMp39BrlxKI9HUuVaidw1+NzgD1?=
 =?us-ascii?Q?dwKms481OGAaNv0pDfUAOfWWfXCge3wlXH9DfcqVxtrSy9mXxIFfcxvrh6Fk?=
 =?us-ascii?Q?U08PAtd8F6/ZThrnTJjzAoJzgW0+T02qB/BlQ8F8ezt0Hu9hkoPsNHJe/OL0?=
 =?us-ascii?Q?5ktkwfKa7qkcnF1NRjJeyvNt/+rcx6zQXSXOJ5Qxwu5LN0Ubn8qsnwgL6ZVv?=
 =?us-ascii?Q?sjmC3VMurd5CyQgG4kslsWWTum6EaHBdzqYUcrgF6fl1phQj0k2fzCW2uhIS?=
 =?us-ascii?Q?ZswXs/yjymSOVqHNs0glJKnLMc2KDX7vNeVnZMzHTC1/p/k2MIVT5gG8Wj4N?=
 =?us-ascii?Q?zm93HFTkjQOu5P+535Zcs7NnOGUBa4sssEKZ2adI+JUpPB1NBLCFIIqzRxV2?=
 =?us-ascii?Q?PfahdQdGsQH+zdnItINN5Ycld+ie5A5QDzsPJxogtv2mUz6pGKtJY999yNnU?=
 =?us-ascii?Q?VsDL3eiz3o8UUH69d6WsdDc3U7uR33eyAwZuYly7dTwmujGsT4uJxO3ka+Aw?=
 =?us-ascii?Q?dEUr89l7XZLLYRsxl1b6xBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4K3yzdk5mXWSb+3H8hClG5YtebKEZaapjKzozz/ljPpIKWOXAxa5tAjXyayE?=
 =?us-ascii?Q?LVrJ3WYXVqYJgDEnN2Cbzxt8Yhql2nxcG4vWGnoBQyM5frYV47vs96bagMj4?=
 =?us-ascii?Q?4o3hyUzMGDpodfMmNSu906OxX0v5I/Ld45jQPUxTCBeXRd5LK8Pwac15TkAv?=
 =?us-ascii?Q?c5lXdgaNnIvCGr573uBetMhcau0OAldZekCr0oC4mVpSIaNcW09tctwSNsoV?=
 =?us-ascii?Q?Iw8m6hmlABtn1XicldtgB4OwfpTm+5CAsaFjfiTeXSbc0zWHwJhYwYq0vI4+?=
 =?us-ascii?Q?51f4SHkvy8WZq1sQ3e4CvaqVLEG4pI++fN47m1Gyke6iNBECLTHrcfmWixKg?=
 =?us-ascii?Q?NHpzYXe0GQEFUixFKmF7oKNKwO8Rw3tjW5+JxigzAX8fESAWM5rYSkqOMQcN?=
 =?us-ascii?Q?TmU8EGghAWpNjMKv+a3qSPYmC8hRGXt4A4t30K1EiUVmeL0zsjroxDiFAJYU?=
 =?us-ascii?Q?Rv5WrOWkjnskfd6zsanB2wMmrJC8PQ9HMhw6r9b7wI7KoyNQdAv+FZ1g718A?=
 =?us-ascii?Q?bH6Dkmf7bZ8zqnwFFxPSV2wxtd20CX7l1YsK/LRN9pOGa1Vbl3HTODflC0hz?=
 =?us-ascii?Q?Q4hrBPHXnaQzqKGXIpYhhE0Gts/HV+5GO3QY6VtEPCqy1rrb56KXDMhRPkWy?=
 =?us-ascii?Q?aMoAyJ1cmGvjI8oatPs21pHP/1yrPOjD1B+CnfE3opyXh2Frd04vzi4Y1Naa?=
 =?us-ascii?Q?Sre1OF1O44A3MQinkMe76gXmtnkGmoDOYCq62zUrQgjqcfp+EFLjWskEQwEZ?=
 =?us-ascii?Q?d+TpDcUZSfH59g/2/RzInpKAxVj5fagdEVeSG5xbAXEwIuQJ9kDsnGHcUNoQ?=
 =?us-ascii?Q?TbM8Z+Jjlz+KY+U1YbBANNe4Ppt+aSpGYnQxZOEj/CTqCPO/HmxWtR43ii5b?=
 =?us-ascii?Q?34VHK228/iQCVEb0tN/5zjzfwH2NUyQa4HWxqUQ/TcLkFuYx83foG0/dAKRl?=
 =?us-ascii?Q?7/n+Jy1jO5J6ZCozKe6nWBnOpZQMSbO0O3FXMeq2vsykDy+G6BwCCEI3ktVt?=
 =?us-ascii?Q?pQ9+HRVbwv6197qp0MNo025bkWoAYY+NP+zcqwrxP2IvmLKrO5s0/xCJU/3X?=
 =?us-ascii?Q?n8OmCBQS7wwMMndJu7eCKTSReot1AbTu6UBz/c1wqJpX0Mb+aq/ckK5mKkuW?=
 =?us-ascii?Q?Gxxe6o5mUePmEEdlWx+BAFHlescx1lohDepb1jqGon8VM3bXmXKktjaV59pE?=
 =?us-ascii?Q?M/r5x+5MMRyj52g3+pT8Et3bhb5Lu7F++lY5vmA9feBXckh8fjcn3elgydzf?=
 =?us-ascii?Q?ryp38JIWOERRTJwmuzGMTroeLB+M7cnodHwEuhX+DvqNifCJ5zy0l3f5KFwS?=
 =?us-ascii?Q?p5xwXKlNsc9/HlDcEu+W6A5G/cbwlIJ1ZFEETEUGKRNL+NjF2S0L58MzxJPG?=
 =?us-ascii?Q?PkpQiG8QTxg+NSczKmpfQn+ikaO1YlUnX1OVmOxnv4BbcEL5mFowIfsxgeyO?=
 =?us-ascii?Q?WXYKAQ3R6D6p7eiOgL5Ezxeg+zf5t8zghxZTY2M5FLw5x1zMNFw3F3QbahJ/?=
 =?us-ascii?Q?7c+I3Ar6MvrC6yEtc3h+p/qRfwD703vLoZoElyK/Tgl8mVascBK8XQnj00Un?=
 =?us-ascii?Q?xrmsMTNcwBVsNX4ztLzyAT336IWwXxSgOn9g8OwpgGGzszKDmB72pkgKhsaQ?=
 =?us-ascii?Q?RUcujmHU6Goc/XboP03HpLSYSPzyeAqc1lJq2pvwdMgfpXwPwwf1q9LTp2nD?=
 =?us-ascii?Q?dmYUAemaDCIouBGitveLsKN2VjY9iha8anBnouRu5dVkyOHuumxlX2fG0iAV?=
 =?us-ascii?Q?Ex+PNmnrLQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844bdfc0-5ea8-4691-9410-08de6e431729
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:39:16.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anHF6Km5eyP519o91DnHIVm+cspq5WfxCNQN75HhGL9iwL671rvO3KY11n/2z1UThBq4PQDFsx4lfOeTlT/ePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8918-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CADD14E537
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:48:45AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Frank
>
> Please check my responses inline.
>
> Regards,
> Devendra
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Tuesday, February 17, 2026 1:16 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the DMA
> > > transactions using the non-LL mode. The following two cases are added
> > > with this patch:
> > > - For the AMD (Xilinx) only, when a valid physical base address of
> > >   the device side DDR is not configured, then the IP can still be
> > >   used in non-LL mode. For all the channels DMA transactions will
> > >   be using the non-LL mode only. This, the default non-LL mode,
> > >   is not applicable for Synopsys IP with the current code addition.
> > >
> > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > >   and if user wants to use non-LL mode then user can do so via
> > >   configuring the peripheral_config param of dma_slave_config.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v10
> > >   Added the peripheral_config check only for HDMA IP in
> > >   dw_edma_device_config().
> > >   Replaced the loop with single entry retrieval for non-LL
> > >   mode.
> > >   Addressed review comments and handled the burst allocation
> > >   by defining 'bursts_max' as per suggestions.
> > >
> > > Changes in v9
> > >   Fixed compilation errors related to macro name mismatch.
> > >
> > > Changes in v8
> > >   Cosmetic change related to comment and code.
> > >
> > > Changes in v7
> > >   No change
> > >
> > > Changes in v6
> > >   Gave definition to bits used for channel configuration.
> > >   Removed the comment related to doorbell.
> > >
> > > Changes in v5
> > >   Variable name 'nollp' changed to 'non_ll'.
> > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > >   Comments follow the 80-column guideline.
> > >
> > > Changes in v4
> > >   No change
> > >
> > > Changes in v3
> > >   No change
> > >
> > > Changes in v2
> > >   Reverted the function return type to u64 for
> > >   dw_edma_get_phys_addr().
> > >
> > > Changes in v1
> > >   Changed the function return type for dw_edma_get_phys_addr().
> > >   Corrected the typo raised in review.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-v0-
> > regs.h |  1 +
> > >  include/linux/dma/edma.h              |  1 +
> > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index b43255f914f3..ef3d79a9f88d 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> > dma_chan *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     int non_ll = 0;
> > > +
> > > +     chan->non_ll = false;
> > > +     if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> >
> > Need handle EMDA case. if mf is EDMA, need return error when
> > config->peripheral_config is not NULL. Or remove above check to make
> > code work for both EDMA or HDMA.
> >
>
> For the case of EDMA, the behavior is unchanged.
> Even if the config->peripheral_config param is set then it would be simply ignored.
> This is retention of the previous behavior. This is done because device_slave_config
> has other params which affect the behavior of the DMA transactions, we do not check
> all those params and return any error. The error is returned only in the cases where
> particular parameter from dma_slave_config is used and if the parameter is not as expected
> or in the expected form. The parameter used from dma_slave_config for the particular
> IP type need to be known first then it can be checked for its correctness. This is behavior
> for the peripheral_config which is used for HDMA and thus error checked.

It actaully hidden error. Your patch provide an option, which need't ll
memory to do DMA transfer. DMA consumer actaully don't know which backend
used, which is private information by DMA engine providor.

dw-edma-pcie.c is only one of all edma users, which know DMA engine's
information because it creates this interface.

PCIE-EP framework also create dmaegine, PCIE-EP function driver use DMA
standard interface to get dma-chan.

if (config->peripheral_config) { /* only your specific dma consumer set it now */
	/* optional config information */
	if (chan->dw->chip->mf != EDMA_MF_HDMA_NATIVE) {
		dev_err("edma have not implmentent no-lll mode\n")
		return -EINVAL
	}

	...
}

Add EDMA support no-ll mode is quite easily in future.

>
> > > +             if (config->peripheral_config &&
> > > +                 config->peripheral_size != sizeof(int)) {
> > > +                     dev_err(dchan->device->dev,
> > > +                             "config param peripheral size mismatch\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             /*
> > > +              * When there is no valid LLP base address available then the
> > > +              * default DMA ops will use the non-LL mode.
> > > +              *
> > > +              * Cases where LL mode is enabled and client wants to use the
> > > +              * non-LL mode then also client can do so via providing the
> > > +              * peripheral_config param.
> > > +              */
> > > +             if (config->peripheral_config)
> > > +                     non_ll = *(int *)config->peripheral_config;
> > > +
> > > +             if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll
> > > + && non_ll))
> >
> > if chan->dw->chip->non_ll is true, It should return error if you set non_ll false
> > because no LLP base available.
> >
>
> In case the 'chan->dw->chip->non_ll' is true, then the default mode becomes
> non-LL for HDMA ONLY. There is no option to the user to configure the LL mode
> by giving 'non_ll = false' as part of the config->peripheral_config.

This is API's callback, you can't assume caller do all correct things.

> The configuration of default non-LL mode depends on how the IP is programmed
> by the user. The user is aware of the IP configuration.

It is not true. DMA consumer don't know such detail information, which
only know which dma engineer providor.

> The check for non-LL option
> provided by the user is useful when LL-mode is default. That is why the value of
> non_ll == false is not even evaluated.
>
> > > +                     chan->non_ll = true;
> > > +     }
> > >
...
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > > 3080747689f6..78ce31b049ae 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > >       enum dw_edma_map_format mf;
> > >
> > >       struct dw_edma          *dw;
> > > +     bool                    non_ll;
> >
> > Can you check ll_region directly? it should be equal to (ll_region->sz == 0) ?

Do you miss this questin?

Frank

> >
> > Frank
> > >  };
> > >
> > >  /* Export to the platform drivers */
> > > --
> > > 2.43.0
> > >

