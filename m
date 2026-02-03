Return-Path: <dmaengine+bounces-8698-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e6ZVNuxTgmmYSQMAu9opvQ
	(envelope-from <dmaengine+bounces-8698-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:00:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38074DE524
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D27B53060BDB
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018191F09B3;
	Tue,  3 Feb 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y/Fzs38z"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B8219E8;
	Tue,  3 Feb 2026 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148841; cv=fail; b=VLJLq5J+4XnG0SALAiLy3ikuKCWzDrIqVWcBhpEkcqeMEkXhZFcNFW6baXpZfyZCsbeac2V+90BKlI2E5s23MnCnidubuhxcGwoQW5lgqFjRgw8SWSDG1EzXNQ9f1RinHpVPUt8VADufclHJ6OIIGQGkm9Rw6KB6r2sSLqk4+60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148841; c=relaxed/simple;
	bh=gwFV4dY+ELhhR+wMkfnT9RLgefzOVyGBT+XwNBwvLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EBOFBvkiOBRYtQm5bE3qmQaEr02JfE6PBsB6+STnf1gfsJ3+2DYB4487IDNuqMwgj4EtXNEYSEipdM1iQcxKqIOibLZx1L7wCKyt+DoeAuajU5E3ms8Rk2I/UDIpdWF5IhzM4s4MVrF2oRuMjZTXZ0N7kSiH9jwdh/C6sHg/+gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y/Fzs38z; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7XQOgx3aR78EvdZbNxveRnE4wSfqEFmXI6GLpKTZg3OCI5RYE501eSnIjByugKHCjZYLm9Jxz3Ycmtwi+ji3tXC9UqVK3O2JjSEo2NvJAym2+mL5r9gjXpIYoNSFYWeQ0zjkc374iyPQCtlcG78lrOA1/L5y8m7r5vqVYZLrD2v4mN71Zcos4zrB0IbKL+5CO2FPrkouMY5VKpS0k6PD+7/GnFsvMJrRk4EJvA4gRAp+0mB99Y7tTQrU+EplEqWFyps+BPtNMJ41we4NuXZ8wO8YVThIeSE+jFpl2TVsl4vCYbXdB1unpgjP7n/riecKf++evpOCZW865pN2r6AKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmgRk826b5d9iHrKhx7LFLfLMno9PruaNZ9UwqNylwc=;
 b=nrmWKVbs1qzyTNwhxMbp1Gmtluf4y988Gt0f3O/mjn5N9oQ4UGfBr1Vko1mDIM48lC0iysjwLd9OAToAwDPD7/kFkJn7i9/l0QAVJfuHDMTKyXZT/943OxNWH1ykfrsEZHl8k0Z1h6kcRMfAWdplWjCzdpJ6kAvDmnEDUEZD6pIiEzMI0CgyPEY04Lc8JLI+xxXYaY2ASZzmf+Xfrbthwdf59nnYtWJZAdKbrLwWIBkDmhOBitV7Fi3LdOugJLO/5lHZCtmujgHs/46fPvidbmM18nbJmj1eIyX+yGaQL0fBd9mZRgNenqDMpYAblcVmVeFvUfeoSuATvEArEn6LYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmgRk826b5d9iHrKhx7LFLfLMno9PruaNZ9UwqNylwc=;
 b=Y/Fzs38zic0HkqLKKx+dbEW5N+LGkwEv6wHN2jl7yTibPNcFT3RLuLs1sUhlRJMgu1jykR08LJ5K6Duxxt6mpLQUnt49Ad+DnRQhdAJLI1tpGww10Tz2Q5P+NazcHCQ/j1ULkRDYd6U3bRegqmkxglG0i0NyXPxjJEmbkSV4Y3sVI2GO+1Dv9qVQ06CTCIjQCDUPcs961Brwgl3cY8UWgs2OUV/23U056RJvNmDu4FyDtQhOqAkBaobB6RWS7lsNiFxEvkQfuqunRUhJhOTZ/iI95r6Yub1jmSCYMqeLuCCYIn9A4bhBpTExvqL7Esw4MDnB6HLTeBigMaNMRcdJQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 20:00:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 20:00:36 +0000
Date: Tue, 3 Feb 2026 15:00:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dmaengine: Add Loongson Multi-Channel
 DMA controller
Message-ID: <aYJT3B/vgjklDN46@lizhi-Precision-Tower-5810>
References: <cover.1770119693.git.zhoubinbin@loongson.cn>
 <7d6bb6ddc9b2d7c760fa0dcef30123f700e47f77.1770119693.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6bb6ddc9b2d7c760fa0dcef30123f700e47f77.1770119693.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 88756983-f027-479b-d010-08de635ee5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMH/jOt7Ov01WZw5lvtm7Lr5XSPa1bPvs248bK+3kyKbM0n+zBcJpqwsuAQk?=
 =?us-ascii?Q?hBn7H9OInT8n6eBqCCp4ijKd62i06fjl1Kc16SXjGkSFVXZeOC+zoSd5OdYZ?=
 =?us-ascii?Q?MdxnpDL4zBCoNZNxXHhjVqEUilROXa5ZGNZykXVjeTIGqJxUqXmPCAY2mDBM?=
 =?us-ascii?Q?++MxCGB87TBZuNRWL2aRMMhBngMeG17I6pa05Iip26dxWpBN1idaDWUrLUHb?=
 =?us-ascii?Q?hhkj9MBeY8o0qTlPZKwKK5m3Wi6Ce2UUGqEHAPEhSrq9h5o+lyZc8lNjWeBe?=
 =?us-ascii?Q?S5dzcepnx/oYV/xAJpFntA5lbGHyxs768KQzEP6nfniT1a9mImniogJi6kgl?=
 =?us-ascii?Q?eSEy1Grc2jh5ndhqSI1TctwfxjMa+cm8RxiAAQBn1CukvnDzOf36PIJQ0qiN?=
 =?us-ascii?Q?Nzt0W/zxuc4yXZT3NbNLv2pM8B3NVfSJuLKdvGJ7CRA2BnuY6/7Fh62+lyoF?=
 =?us-ascii?Q?jk5JjTZQm+h9xrwZXiJRqcGUU6d8yQez/ExnuibaoZRfnh8iJM+iDsv8z709?=
 =?us-ascii?Q?qBRdfydR/QeeMG0AJmN35b/Q/EpuAjKh89nv3kN1uG+SvBv7l6tDjo69vkGC?=
 =?us-ascii?Q?MYSM9NcZ8I2UnKJdrbzJPdMgf/mHsddz8yRni3ArWKNSt/Tev9rakY8fBpxV?=
 =?us-ascii?Q?I8RXzRV8rUasfdlbwpnIQKMwON0lkOO812vf7ORq3sc050ulWGqxiYwtsmS2?=
 =?us-ascii?Q?LrNqPntJUbA70vIZBUtioCEn/wnDjqgeNCFRMS6L9S3sQU7BM7BTE0fSLtUu?=
 =?us-ascii?Q?JDdgB7irzfCmDC8OR1R5dcDup8Ar1Nzcbbrd4kr75ai9TXRtg6iOHoraW1lC?=
 =?us-ascii?Q?oi4PDsgDIUBHpp+IHqzx6pDihwXSab/ENMXNLB0KKzFLWLpo7Uy3SK/dGR8C?=
 =?us-ascii?Q?CJT8qaY4HUGdqUQ+Yf+cSWUPpMazYIi0RiIgnl3Heuic+kD8czgzcO29ScFj?=
 =?us-ascii?Q?CV2sjexiRVYoQRC91ql1aVHwvZZszUZTKaU5N2sOrFOudlxEfVEbwskTjAIN?=
 =?us-ascii?Q?0TXapKvv6a/DfjkQxo1Z9UrYeAL6v48JeVI1CHgOMrGWS1SyVprCPNCr2Pd5?=
 =?us-ascii?Q?3YKz1FDQkaQ44mO6kypiXTI9jtb5avV+35WsLlwdzHmIvuuhNsVQtLh5zg5o?=
 =?us-ascii?Q?u0W6XQV81xeWzqbKBlwdJxeJjkJXT4jPvBSGpn8yvq4dSFNAGLqLuej+IDos?=
 =?us-ascii?Q?lsIDMs8Oiz0nr2QZtLcBG2XJT120L5GV9FkvM3xXexUtV4kreIXhGTdrEk+Q?=
 =?us-ascii?Q?u6UsuA/LlLO11xWmxiaiQ+SWqbQb7ioPXd5zpyeOeQW54CuHZj3i9/P/jzMq?=
 =?us-ascii?Q?XZJlabNafRXD75374tcvMEHzCF8aJkElRJM7QnJ1tDQGUSBdpgetcT1pK6Zb?=
 =?us-ascii?Q?SuD6f4vFuTzcLgNxUkV58nkjHGksXmpGG4NEc1fotlWKSym0YHahCw80YXJz?=
 =?us-ascii?Q?PJFY2U8ZBI0dpfkd0NJ7Q8OObID7v+dhkSE7B6Rrcrnd+Oik69BJYz1slc+/?=
 =?us-ascii?Q?erC6qLsSoCtX2nzXXYgfLwJxaXKfSB1QiTBB/Yotvvt1FPrUqV4vnsm5e7e+?=
 =?us-ascii?Q?a3UjrtJEk5A9eh+yUc7DwRNNDwpJaiDteLWcGY6r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYWMbQ6fgerX31zitAJRxjBxstjP36aDm/va3savfaaTrGwLKqZ33cOizIVK?=
 =?us-ascii?Q?KqPFqGK8mFC9Ph23eveKxUVeCBQ+D7m52KSjqbwqsn/ZIdmnNrBHJ8nsLwmJ?=
 =?us-ascii?Q?4CmLOEuFusBfSnmJ0JN5BCZleC++Az5Ybyp/5xUxlF0yW20C8iVajPeRJGzs?=
 =?us-ascii?Q?GgKTxQj+wN221Wenxd9RNKzzd75xEvVWlo4pyXP/syJ8oCfc6DxwW8FZyeFV?=
 =?us-ascii?Q?6gymUHvl1tUnvWhCZfwn19zxFFUGLI4pZphxOdM2/jyBa9b7zbnBC8Z0NTvj?=
 =?us-ascii?Q?7SgnlPMiRXURclvV/iITO4QvzcGnU7IsMCPGiINyCs/rd/V4MsX1Enya5yfX?=
 =?us-ascii?Q?vClGuu0XQQRgGDPRbbnTgNXrECc8K2iJBkiemXOKhYIR+mP/+zd0tcs6WCp4?=
 =?us-ascii?Q?YxSkJWV3epuHs8VUisua70ksUKWpMtHPoxyGnlHYJZMA5L/51pPJQPIexzKi?=
 =?us-ascii?Q?E1ScJYgVfcyslNHsbAJhf26j3ahNFi4qufPGF1YWh1v2Tp37DGqkKbaeXqZT?=
 =?us-ascii?Q?0wokMtaoc5oifKzETqAiqY/7PGhPq4vDkJOulQ3AdkEbPuycMfltp7QaXpTN?=
 =?us-ascii?Q?W4i2R5w+h6vtFq11B7GEneIUhOQjQIYldOQ0/yM+Fuh+MLoFP89E0fvTKPc6?=
 =?us-ascii?Q?uW1Qf35rbiHzHumbHmWUhQ8ByeNBzS+r9f9uG3ce3P62OG3V4nxBgIYqQQdv?=
 =?us-ascii?Q?vwLafgGGweLosCXrRYvGOWpHjFjRO31YUxovnA5Bv05jwaxu1kUtr1KJ4aoJ?=
 =?us-ascii?Q?bwwwHqilMg3gR7pGTOxUSYSesUE3wsMnCxy0RZ8bAhQbvXS50ZqtxeNsVn8Q?=
 =?us-ascii?Q?P9NdLUvnA6sx1v0uO/3zLIC3H1lgGDnhtgpEIqZCWBDS1tILBbHEA8Jm0nwv?=
 =?us-ascii?Q?9Z1G5kLdJfXlaOrXcHmaLne30CUJs2GuP+IlPFLDXh4zXoX4bkQhgHbPfJq4?=
 =?us-ascii?Q?YcepF9y8Ws+7vvYF6wvDYcOZ9CCH2po9fl4rZKqX0OxeJSZTbbYUHjzAXe4F?=
 =?us-ascii?Q?ssM5zphTQyecO0JAFXzua2ZsGIGSg2ZKsLlF5vm7aA/5okzxRDvHkJ7zEpbN?=
 =?us-ascii?Q?I5TJfLUh+iUvDy4PhL7+x0CXkYzTj8ppe4u18Zltom20oyvx6FFFz3dAdU+N?=
 =?us-ascii?Q?i6aUIql4NKaybwKlHbmr2ppAedGBRFpGlMPInhP45wSbVZ9mgtFdUQEcL2G6?=
 =?us-ascii?Q?bRekSds+4yk+W8EY1kuv/pBMaHr0cMw6v40m59u10ZzpaO4UEgpiGxtJj66A?=
 =?us-ascii?Q?mAudbgpIRko3ebq/E3b7Pu5xvk2ZT9sw8iMUBF7uxy/qIWdbTA6w+o0D05ka?=
 =?us-ascii?Q?3+9ganNX1KM2oIsXCvvDqoYS5HNNy9aYG5JvIxkmfAJmeguZyUMDhjY3jVpJ?=
 =?us-ascii?Q?4us0SJtrWz0clft1787qVS7CjjjJsATwkkisbBcSlN0LmzpcFMOG/iIbtoGM?=
 =?us-ascii?Q?m198aOZWrHdRxWDLK93spwQUP+uI/4m5iF+sBipKriS8BNx6gwPPvJ3n8QCF?=
 =?us-ascii?Q?4/o/e9awl3q/2YoAiwNLJhbh2G1Vw2wPE+0j/Mje2umCGJDRBzWahl4Hyf3d?=
 =?us-ascii?Q?OuhxJbqb3GBCr2ULJdSkp2jqoMFj3N1EWnTzq5mAkYywVJCDenZ7f8x+SrDP?=
 =?us-ascii?Q?bkE8WYXfPj63/NjiVvXZbQ6C43YlP7m+bKbTk4rgNZqokG6Lz5YG9lrVnOTy?=
 =?us-ascii?Q?Mtj3cdHK/22C8cTzRBDi1pppmv5TKJlrOlp2MaeYMcLJLVsu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88756983-f027-479b-d010-08de635ee5c7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:00:36.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8Tx+8QeR3ua/xf3HsA1b29WuilruCvv/acGaQGy11nMAkUomjd0frj7uc/lI+uxug6PlrTFUmWRhlsjunZb8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8698-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,nxp.com:dkim,1612c000:email]
X-Rspamd-Queue-Id: 38074DE524
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 08:30:11PM +0800, Binbin Zhou wrote:
> The Loongson-2K0300/Loongson-2K3000 have built-in multi-channel DMA
> controllers, which are similar except for some of the register offsets
> and number of channels.
>
> Obviously, this is quite different from the APB DMA controller used in
> the Loongson-2K0500/Loongson-2K1000, such as the latter being a
> single-channel DMA controller.
>
> To avoid cluttering a single dt-binding file, add a new yaml file.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/dma/loongson,ls2k0300-dma.yaml   | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> new file mode 100644
> index 000000000000..d5316885ca85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls2k0300-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Looongson-2 Multi-Channel DMA controller
> +
> +description:
> +  The Loongson-2 Multi-Channel DMA controller is used for transferring data
> +  between system memory and the peripherals on the APB bus.
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k0300-dma
> +      - loongson,ls2k3000-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 8
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 2
> +    description: |
> +      DMA request from clients consists of 2 cells:
> +        1. Channel index
> +        2. Transfer request factor number, If no transfer factor, use 0.
> +           The number is SoC-specific, and this should be specified with
> +           relation to the device to use the DMA controller.
> +
> +  dma-channels:
> +    enum: [4, 8]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +additionalProperties: false

use
	unevaluatedProperties: false

because there are $ref: dma-controller.yaml#

Frank
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +    dma-controller@1612c000 {
> +        compatible = "loongson,ls2k0300-dma";
> +        reg = <0x1612c000 0xff>;
> +        interrupt-parent = <&liointc0>;
> +        interrupts = <23 IRQ_TYPE_LEVEL_HIGH>,
> +                     <24 IRQ_TYPE_LEVEL_HIGH>,
> +                     <25 IRQ_TYPE_LEVEL_HIGH>,
> +                     <26 IRQ_TYPE_LEVEL_HIGH>,
> +                     <27 IRQ_TYPE_LEVEL_HIGH>,
> +                     <28 IRQ_TYPE_LEVEL_HIGH>,
> +                     <29 IRQ_TYPE_LEVEL_HIGH>,
> +                     <30 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk LS2K0300_CLK_APB_GATE>;
> +        #dma-cells = <2>;
> +        dma-channels = <8>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66807104af63..16fe66bebac1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14771,10 +14771,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>  F:	drivers/gpio/gpio-loongson-64bit.c
>
> -LOONGSON-2 APB DMA DRIVER
> +LOONGSON-2 DMA DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
>  F:	drivers/dma/loongson/loongson2-apb-dma.c
>
> --
> 2.47.3
>

