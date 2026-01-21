Return-Path: <dmaengine+bounces-8432-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKlUIwAPcWlEcgAAu9opvQ
	(envelope-from <dmaengine+bounces-8432-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:38:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62F5AA60
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84DD267022C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED41037F726;
	Wed, 21 Jan 2026 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mbct8Am2"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB6361654
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011527; cv=fail; b=F6wfiTTAsmlAFIZhUtERKHnE0PGdKCXmdEqqGPBxzJeCHB1TkTz+DD1zRr5AfvdYA8drTdKEvnQ/17YSsAzFViS32cBXSVu1r2Zu95jwDAZ55STUhxSzAbQKRKkTNtKLDPNC21UzIliXrMv1YRR2WpH8zBNNDflZTHMccFAV0F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011527; c=relaxed/simple;
	bh=H7gMQmQvIlYbk5NQZ1tRUmdHaKeyZyeopYyMUHnJPH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGrkX6/AlQUfzIHVb7i5ORcL6rDnZZ8YabCj5o8HDBCjuxgBYyKJ9FQf+i2hS/7G9IGk8B0C0Tn1OvDi0ghtGnC3dAqIanBlV4WwOI4fthitACqBzFxcljOuf1brKB4OHI66hryzZ3Bay9DJNskuq7SSRwZ+y0jn87oflkrXE08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mbct8Am2; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz7YhdzNt/FJEw/TkwgJFmZFMVLw8zCJrNSD0vzQ/ovogERvprbiWW2EblXLXcl0v5ximXVY9JYsde76tRVM1vHCH+PRkOyr0hYz7kFj9PiVY6qIKTzTuu7mhMMBGPSQj/XSuO8LyO06C58e0cwAbBeFkMWsmruDkTsyQucZ7he/L7/C730Vi0nlMX7ZZKB9pkTg5LyuUUyre+WPJNQnw7DpN4QfxaGPJ7ajl/uCu8P3CyeoFgbbJXF11LquI82SdzcUfBW+lTG//IIO19qdvaOQxhs6SQ3GTlofDD1DIJxyx8qWr9hfobnF04MjMM9sFOxv/vV0GcDjjU3p2T7+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkANZUA0lk/t7//yVg/5HuXU3GmIKpaseSrRdduAsm8=;
 b=ond3CxGf3ifte9WM9rvxZNdzt1Lkp5ascRn0IcM/KuaGc5Rwhv8tw6bRGNB0RLho8UCEGOSbDf5vSc9A7HN5rLNcVYL/44sPE3s3aVXwA8ZaNpdAB2g1uVfgpDpHola3ScN8Q2hvYeU5KeryR85Fdpg5bo6pwLGA/Ag4vup6nThWlJkUDvdw9DFNvaFsjSI+lsO51lQPDjWNEIlIP7MV/TzX+101kV02vAxOu2JVCIbCPM+oA7ZQLwfEFnmYpr7JngqaJm2BsOoLH8bQ//7rBWyw4jUKFFEsal8BU2b4Dw4l6h2JvQcXaM7vS7hy1ziJ5UanQbGd8krcumfXnRci+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkANZUA0lk/t7//yVg/5HuXU3GmIKpaseSrRdduAsm8=;
 b=mbct8Am2kl6ernk1EOP1cYSOSYu0MrRGZHR44Zb9crey9d3S68OQLUAmXu0OKlvGNETNGD0zXIOAtzuIshKyuG/Xyx879k4Yd8zSxQKjSf+q4GV9lEG7ptphfrOYOPohGLr/hM1xwFRqNM+yxJ6iluJg6atbB421TNUCjwMk4PZVc0sD6T1w4gK2DT9BuZN0gOOJalYWzILxZnfjXuprvvVg9cJmiw0WSPStDFB1VMmMjjYKlgdcPqgkNN9VJMmMZ+BPy5MZjK3GK8IHWy8rkBTfGnpKMAAnw8oFuz2CDAVRuGOTFx2zdR3S+Rk+ncy8xyK3nfKM3y2mj/MvYCtO/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8986.eurprd04.prod.outlook.com (2603:10a6:20b:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 21 Jan
 2026 16:05:20 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 16:05:20 +0000
Date: Wed, 21 Jan 2026 11:05:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 1/3] dmaengine: switchtec-dma: Introduce Switchtec
 DMA engine skeleton
Message-ID: <aXD5OUMQLshOeQXt@lizhi-Precision-Tower-5810>
References: <20260121051219.2409-1-logang@deltatee.com>
 <20260121051219.2409-2-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121051219.2409-2-logang@deltatee.com>
X-ClientProxiedBy: PH8PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 555767c6-269b-4135-0483-08de5906e04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JueVhAQ7J9Pt3dqy+r/wkt4XeuZE5UhCoA1hpuHsmjqBneiS+YwrAUS6kOJB?=
 =?us-ascii?Q?yd2kksuX+tzl2CzYs7v7SeEdcCB/oDt2U9BfaXaLIN+tX+9hLNW2AjUKyoH4?=
 =?us-ascii?Q?LMfXDRPcvVlta+gaApiMWv364ayL7y2Y1jmfL9l97I94KSMq6NeIiLyel4ro?=
 =?us-ascii?Q?0Rtcx/NnvdZVtGe/O3fCQ0J7xRpvI3VpkWWUftd+wZzu/Lk1BxUAOL2m531I?=
 =?us-ascii?Q?lUFBFMnz8xhTfhsTg8C7dX+cxKjN5f57XcP9gBdukB7BEWGyAifDFVZBEGqq?=
 =?us-ascii?Q?D1r6Ht2Wl94AtUiLRuyAqV5rEf89RmFQib1IQfM0i6p/tG1MHClYpEjs/MXl?=
 =?us-ascii?Q?lTSvtYRlNG2yhlmOQcF0BBRFhAnVyPZl5DvOS6586FrtfrwaUmURuffBvhaE?=
 =?us-ascii?Q?JABcepz1Ua5DYBdg/npRQganosCdUEP7D06hrPqBvvF4mkgbyPVq6HoWX2iV?=
 =?us-ascii?Q?CelcKuI9JFucjHsyvn5I3LQesqiFfnQeJRexndV2FiuSlWhvmx4yCr36hyRN?=
 =?us-ascii?Q?xjtKNVNoLylkRU0Vt1ZT0zQUytjaF60bVrxchfR4zIKu2stB/C+16F0mlxYR?=
 =?us-ascii?Q?aUsOtifa6t8JPLpQlT4bKAGQMQreqvxBbDFjbul3eEZmcbbbY6wfP0W7SKVQ?=
 =?us-ascii?Q?O6BwcMCUdvcEW2c5q8aYsVmxDqeeGv38/yztRC1TDR0jKtkgRLnNrlv1j94P?=
 =?us-ascii?Q?L53ye2CMza7twcyn0DXkg8ORLFPVjMXZZ9Ml1RcDUTly5Ckom/fW2pFLy8Y3?=
 =?us-ascii?Q?rOIP8Icyh5oPD0xOakRMIK3hSc9Ux3dS5KAT1CP9Cmf/LbBwGoKlSbxzAGV3?=
 =?us-ascii?Q?+E0/rMXCdzczikft41EuLMo5RbwWYW86sny/ktTXVo9QNJAw/4mk8HNOMiXt?=
 =?us-ascii?Q?O9qT56DxPwNawRYsLNWhklRZA/06BAYfBcUBLVxqMlHmoFv2lqLxBcH1lFMv?=
 =?us-ascii?Q?8t6lQJH3pTegnehQ8FmIdVhpz34VP/tZiZSASfnpbDVywKa8FuW6KTs/7DUF?=
 =?us-ascii?Q?5E1LZW4aYRtnJ8qsRdm7zAPjyXOidur5nmd1/VA2Ba1lLrCnzDCExXPCF9OC?=
 =?us-ascii?Q?v6sP4uRhjreyOpnIHfnd2p+hrlI89QHtbQkjV9aIx0b+k3G/0dQ4O0YH8Zvl?=
 =?us-ascii?Q?pkGTtolXKGqpxfPnMrfU7vx4RyNIuHxPJ6hEPpKuz7QMYBAcojwmxORIkrUK?=
 =?us-ascii?Q?43n2cnfz7D30uBM+fETGef70VgNTxkEMCPX3sMjHkM9IDhpWYbDwY6FZmmnv?=
 =?us-ascii?Q?xFnmx5xM1K+512eb4AmA7yd6QI8XAiP6thFlPkxHN0uKhCEeHQ5GTIoRtmfl?=
 =?us-ascii?Q?EoNTJ3LQ+cyPDtubDqmbnqCgCYrT7+2NcB1pZjh51eTSh5aXtzKcDeCDUeQK?=
 =?us-ascii?Q?xvJK4+QGdMtcgsZ5d/AauNjJ6oJ49glQMrc4W8bDDxX89Y6s2d4m0jqqkV7r?=
 =?us-ascii?Q?sHE5l9r+fAepD/F7br7mXG3++g/7Vp1Myygwix5xKr02jDz/KFt1Kn/AaeTm?=
 =?us-ascii?Q?eEiRuhzleU1Q16ArxMPVBj+Q79tQtp2TlmZ0c7wyHTKhRcQ28Aw8eQozdPVh?=
 =?us-ascii?Q?hvQtcyN+Hc+heaaTaDEuX0Ked9957bOG1hrenTrQBDRJvWYBhbaND5NSU6A4?=
 =?us-ascii?Q?aca7jPr/D23VgCgB5MTscwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ysMSD+8EGdoFH0QArWWa0yDPBuNN7ldeD8hxaBfJnlEtIr5WzMFjhaleBbB/?=
 =?us-ascii?Q?6o5ZmBNf/g7SLh7HlBDyfHP1IZG4DgGzVAYWSyU7ved5lEHi6p/n+n50yoxq?=
 =?us-ascii?Q?T8+3FfS+1ChM+QxHWXDvNS8gvfBGJ96JFQ+aA+yXilpShEYhhb0wI1Grfgw7?=
 =?us-ascii?Q?Ix/MsUpbNPTl2Y1x403QiqsRRYiRc9h6/qDM+vmHtAhOtYJZKPXQuEbf4pcS?=
 =?us-ascii?Q?UBj4UujTg5Eewj9HsLswzSfMUgGM7K7/VQuhwPKO2vMGn66RuG2jfoVgLLYv?=
 =?us-ascii?Q?CVu35+1ypgpN/KaGGX+qiqj713dNCWyp89ysk7r2q56Pl8nfmLx0BeOPGkuT?=
 =?us-ascii?Q?TV2Jx8mnc9PsOGJH52LiiRcAG45CvKJ/oVugrnSSpTOsMDcAR16MkI9b04UX?=
 =?us-ascii?Q?TPUMGxfHuI2T3ljTKCPHuX89YYU1v/eRinGjpza/J7DzYF+wCsX3RJfhJ3v3?=
 =?us-ascii?Q?QSBIlNzuLfDuZPbc/8UDBgSwDLZCsKeYihZM9xCE1caSOp2wizqYUL9PF5n/?=
 =?us-ascii?Q?/PBgsoPTT7cmrFEkrHrrMVrIP7ZDtLKXUW3K0oAcptDAEDGURiRoTTiZOsTh?=
 =?us-ascii?Q?05sW2oog37ojdI8d84lT+IT9NNVFb7J9nLYlQsV26JLlUYK6eVwj984oUs1y?=
 =?us-ascii?Q?WGCruEai9wf3/uLe3qAiozNmASdtKlA3iqL6fXR3PaBwFa8XuH2uN/TyrTOy?=
 =?us-ascii?Q?HmYfJH0Ou7fl5peYLp14EAPgdQTHhyUzvReiQ7IH/rc47eANx1c6e2RynpX1?=
 =?us-ascii?Q?wV7bZfEMXIHFVbzo27N9//hQn57tYlmzuPFCrW0wgcFgABTd7wJ7Yfdd8fd+?=
 =?us-ascii?Q?M6OdugIKRQoDDuHcW7W9ur2SZQV443aR2OTmbWpcoNT9cYNs6McaCWpDGxo1?=
 =?us-ascii?Q?jDQ3/1bT84/KxeqvWx9DXZwGPdvrXvjyFEfz+Pneyuc6XamcjXfM6T0CXImk?=
 =?us-ascii?Q?LSny5E/URzt2HX+J24IeJKDUldqZC04ajGlJZFEbVNJXn5rf7E5h6JJSY0tW?=
 =?us-ascii?Q?g7zIbXWRxdHlTaqbDmAbb/m2Yw7xCyMlHp0YAmsE/k4xMzExk5xNyRVaZ5Ce?=
 =?us-ascii?Q?3t2RHs5QWooe/xSqqKCWnZhZN27HLyMoANGNJ8I3B0QOeMvJ52iVW3QKDCST?=
 =?us-ascii?Q?Jjqg2d3NJyRbAdttHSUAtr+Qx1NM4AvhBxEQd194NzMWp52IIxfCRODacVc3?=
 =?us-ascii?Q?OzJdgaWsQqkDV9WnCNq5eCvd3+sMZ82T21ZQkQ4lHYy6dGmQjkUXL1IN5CGs?=
 =?us-ascii?Q?IQOzjrdCXMUyBEZPFRrnQot1VNqqn32neSeV6ox3srJSKXfRFPBaPOKY/cnW?=
 =?us-ascii?Q?vCKdl5iRbSOqGcOdW2COcgk+kU+eurmYDNVslw/JgkubIAc6qYWapBVSz9jf?=
 =?us-ascii?Q?mrGDPoLJdOmrfEU7+dK3LiojD/AGq3ciEF+nV10aNrW1AzRcYOU1P34xKg6g?=
 =?us-ascii?Q?gDCQBAi/tEnG9Vf0WTpBUEnsngqEHL6cNbev6vujReYXKpXh7G2k9K36UN8S?=
 =?us-ascii?Q?StL3ev+l3bbEeHCbJN2HlaQTLg2xg6xbIwu2GcYVR7yDg7uDh1OawRl+GR7J?=
 =?us-ascii?Q?loAgr3sbpop/Q0W919V9NhnZEIyX9+ozdBISxkimTNuK3c4SkEjkhKVrOdVy?=
 =?us-ascii?Q?55uR/Z8dI0mGYtI4GBp6Q2d+dPnBxingsGiBrFWSsMBfpAQADXIETEKD5rq6?=
 =?us-ascii?Q?Hrgo+QiCejaqRiPFwsSYyv6aD9LD+dS5/dyyQA5QjNv1fedf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555767c6-269b-4135-0483-08de5906e04c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:05:20.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX4cSikqvzr4fFWXRmUiQgsTxZumvmfgUDaPikr3UlWxHYPd3Nk75w4kuryw7isPgc9r7SGXucs7an5ab3v1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8986
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	TAGGED_FROM(0.00)[bounces-8432-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,deltatee.com:email,aosc.io:email,microchip.com:email]
X-Rspamd-Queue-Id: 4B62F5AA60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:12:16PM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
>
> This patch is just the core PCI driver skeleton and dma
> engine registration.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS                 |   7 ++
>  drivers/dma/Kconfig         |   9 ++
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/switchtec_dma.c | 209 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da9dbc1a4019..b57712a12c53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25223,6 +25223,13 @@ S:	Supported
>  F:	include/net/switchdev.h
>  F:	net/switchdev/
>
> +SWITCHTEC DMA DRIVER
> +M:	Kelvin Cao <kelvin.cao@microchip.com>
> +M:	Logan Gunthorpe <logang@deltatee.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/switchtec_dma.c
> +
>  SY8106A REGULATOR DRIVER
>  M:	Icenowy Zheng <icenowy@aosc.io>
>  S:	Maintained
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 8bb0a119ecd4..85296c5cead9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -610,6 +610,15 @@ config SPRD_DMA
>  	help
>  	  Enable support for the on-chip DMA controller on Spreadtrum platform.
>
> +config SWITCHTEC_DMA
> +	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
> +	depends on PCI
> +	select DMA_ENGINE
> +	help
> +	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
> +	  These are exposed via an extra function on the switch's upstream
> +	  port.
> +
>  config TXX9_DMAC
>  	tristate "Toshiba TXx9 SoC DMA support"
>  	depends on MACH_TX49XX
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..df566c4958b6 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_SF_PDMA) += sf-pdma/
>  obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>  obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
> +obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> new file mode 100644
> index 000000000000..bedc72d9c0ef
> --- /dev/null
> +++ b/drivers/dma/switchtec_dma.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip Switchtec(tm) DMA Controller Driver
> + * Copyright (c) 2025, Kelvin Cao <kelvin.cao@microchip.com>
> + * Copyright (c) 2025, Microchip Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/circ_buf.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "dmaengine.h"
> +
> +MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kelvin Cao");

Nit: Generally this information at end of file.

> +
> +struct switchtec_dma_dev {
> +	struct dma_device dma_dev;
> +	struct pci_dev __rcu *pdev;
> +	void __iomem *bar;
> +};
> +

...

> +static int switchtec_dma_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	int rc;
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc)
> +		return rc;

Nit: if use pcim_enable_device() can reduce below pci_disable_device()
and pci_free_irq_vectors().

Anyways, this ways also fine.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	rc = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (rc)
> +		goto err_disable;
> +
> +	pci_set_master(pdev);
> +
> +	rc = switchtec_dma_create(pdev);
> +	if (rc)
> +		goto err_free;
> +
> +	return 0;
> +
> +err_free:
> +	pci_free_irq_vectors(pdev);
> +	pci_release_mem_regions(pdev);
> +
> +err_disable:
> +	pci_disable_device(pdev);
> +
> +	return rc;
> +}
> +
> +static void switchtec_dma_remove(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
> +
> +	rcu_assign_pointer(swdma_dev->pdev, NULL);
> +	synchronize_rcu();
> +
> +	pci_free_irq_vectors(pdev);
> +
> +	dma_async_device_unregister(&swdma_dev->dma_dev);
> +
> +	iounmap(swdma_dev->bar);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +/*
> + * Also use the class code to identify the devices, as some of the
> + * device IDs are also used for other devices with other classes by
> + * Microsemi.
> + */
> +#define SW_ID(vendor_id, device_id) \
> +	{ \
> +		.vendor     = vendor_id, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> +		.class_mask = 0xffffffff, \
> +	}
> +
> +static const struct pci_device_id switchtec_dma_pci_tbl[] = {
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4000), /* PFX 100XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4084), /* PFX 84XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4068), /* PFX 68XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4052), /* PFX 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4036), /* PFX 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4028), /* PFX 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4100), /* PSX 100XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4184), /* PSX 84XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4168), /* PSX 68XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4152), /* PSX 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4136), /* PSX 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4128), /* PSX 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4352), /* PFXA 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4336), /* PFXA 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4328), /* PFXA 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4452), /* PSXA 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4436), /* PSXA 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4428), /* PSXA 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5000), /* PFX 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5084), /* PFX 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5068), /* PFX 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5052), /* PFX 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5036), /* PFX 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5028), /* PFX 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5100), /* PSX 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5184), /* PSX 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5168), /* PSX 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5152), /* PSX 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5136), /* PSX 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5128), /* PSX 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5300), /* PFXA 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5384), /* PFXA 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5368), /* PFXA 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5352), /* PFXA 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5336), /* PFXA 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5328), /* PFXA 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5400), /* PSXA 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5484), /* PSXA 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5468), /* PSXA 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5452), /* PSXA 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5436), /* PSXA 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5428), /* PSXA 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1001), /* PCI1001 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1002), /* PCI1002 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1003), /* PCI1003 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
> +
> +static struct pci_driver switchtec_dma_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = switchtec_dma_pci_tbl,
> +	.probe          = switchtec_dma_probe,
> +	.remove		= switchtec_dma_remove,
> +};
> +module_pci_driver(switchtec_dma_pci_driver);
> --
> 2.47.3
>

