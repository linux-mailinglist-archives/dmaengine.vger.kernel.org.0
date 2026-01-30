Return-Path: <dmaengine+bounces-8625-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICO6OXXSfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8625-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:47:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135ABC2F2
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 681663019392
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142033FE35;
	Fri, 30 Jan 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X3IEGWh7"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4F33BBB1;
	Fri, 30 Jan 2026 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787997; cv=fail; b=K6SOBXXoq3nGSEplcfJ2KoDVRf6EmZgAT1/fUd66DEglMLwM3iwZx1QhabgvNITbweMb6xbRJSiSMiztG/74JX8SF6BYH0GtfxjveLjn0Y9i1JvCPGOlVwLpp2SZtbyb40/mzzSZy8ukMYC7G8GaNkjgsSFt+XYepsKWEAt9A7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787997; c=relaxed/simple;
	bh=VwHmx1PQaLTdkWaC3syKVX20X0zF7C+lqfET7ODy6Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XzhreUvmxcLdBCS2Pvfd5BRIq+pm5tWwycSQ7Ns787M19SVOfjbHY5N2Hw1VigafiRsZzgTmt0HurwVaxvBcoHb60t8ubBAkKTbNl4/dqLnZ0MfbjUpSiMGMQ+UkjMr+PwIuKXqxBYcG+qSM7wevORDynyM4ScJbDAanuX/I6BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X3IEGWh7; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEdcPmO2hT3bfA0Ec1nRwaFBeyzE9y7S83T+b0fe9MQPK41c5Cibufb/FZQey4xBmS+Skp49WRQe7h+6/vhThHIa6tNiQjVBZ/xLy10JMEe9g3rfncqksrzhG/PhyOZYcpANRiknLsbBgV1OeSv9iGV4Ktk7UKWejEAmIXjMgVC2069cII2NKppR8VR/2jZ2oMVsNVG9U9OQTNtYU60+rh5sv6MfSQ4t2h0A5RtiDEskdZfuXLAoXcv3iwwgFYkikCZRD7vbAYJ4KE67lYjh7NR6I744NCNFI7FhCXJ5TOjVjadGOjOoqgj3FU8xWweYBFfvjkRqOTb1Mg8RoJy5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IPzAc3v+y/+z30vVaURUYTy5GbW0TMGjuWH4DDgBy0=;
 b=G1GA5Gl1lQChE3CilO89cQvv1otqu76d06+WLhvYKHqtxEFudQv9xhrMtAPlbJHdeooHuSoN9zfIYAK+/pL2wBkNrMhCERwpWSo7Jf/zqmOX9Axo+ibQJDA5tsV34x9DrYJLXnwmv/3kZS/NpW8sjd78XmoIviX2nhy/6MUl6NtmgeBS9zrSxvekD794Q8/nkUrHUGNvTMrhYs35xt/habIRmBAN/fjG3f6kXeGv+xI2TlelQH2vQ1UXglg16kKHnklhNgPSK2yHlUj99fHYOYIKYCMQSnsZRaZFCMr/elf8jjoVw9GXPMFJ2tB7S432Ia8D1O/apALS1zVURNanXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IPzAc3v+y/+z30vVaURUYTy5GbW0TMGjuWH4DDgBy0=;
 b=X3IEGWh74joWQs9Grf8s/6D3xdkfIGs6tK4Mw3kO+K4UBCKNimrRzCaMRw4ISiGhgEmJ/hJkpdEKUwhRGuaD5m87pT3JQ3B3n+L/xqY0Cp3ZB8i8PhOmNXUjMojKqLVQlxqBBSmgtZd7WGBVcthHCKpNR47ddBWrCqSOr3gQctA3Gi0wOpjM7+sbWE+LlnTyUcfySDIhFgtQUpaXfUljGjrniJXBOWEwmRZ7C++Kh4bpCF9g+KEW7G4VzZLo7jqrVLSbbVmskFjNSB5M1GH2K/WmJEP+A1GJIAZQSxpf2h5WceyI5jPw5hT1Lng1Wm9wSvo6hwQCEaDhpCiEveaR8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:46:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:46:30 +0000
Date: Fri, 30 Jan 2026 10:46:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 05/19] dmaengine: ti: k3-udma: move ring management
 functions to k3-udma-common.c
Message-ID: <aXzSTYq5RMHmDvU5@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-6-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-6-s-adivi@ti.com>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: da8dc921-36d6-4a19-b627-08de6016bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9nh8TwgmE1682pUNRNkmXZxji2oCqP5GIGN/M1chQEtYFCcfn65TlMH7vDK?=
 =?us-ascii?Q?a/voz3WoqD4gqIEnUYtk5M5TZWtUSqjUn8TSxF7m1uZe0zNei7/iKw5hP8kP?=
 =?us-ascii?Q?bH7Zezx8YAZonlVcGJYPDjfTdexBqTFzTl0WX940tACpF/0ljKDn39Ir4xQc?=
 =?us-ascii?Q?nLqMNTrlnsPG67IlDMypW8Or+Cxr7L62fJdZvlX88p9EMRBxYdGONqGEJK9K?=
 =?us-ascii?Q?VSS1ugbQH+2d3FdG8J+TT1y4bO1Zx+fxN8f6SB0McYx+adMXMpecuXHh5XwQ?=
 =?us-ascii?Q?FnIcr+TDnVEcepF96IC9ohKkcXt1oj93QdSt04MYkWmCF248CFfJvNQrU44C?=
 =?us-ascii?Q?dgxOTyviU8DcWXcEE+CB8YexW66o1w2kOV2n8MS4vRN14UlrbfeEQssVAp1C?=
 =?us-ascii?Q?CxhPzDUWVNdDtehHnwXpL9IIPNEpCFjbyJXEv+n3NRAe4CiMY8IOQM/PSKDa?=
 =?us-ascii?Q?FSfjG940zaJWdok6C7dYJd8/LaJ9gzNa/vFxtGBR4xN2ZJ4USGWkq0IS8ZUt?=
 =?us-ascii?Q?AsvWyHic1uk8DZaU8rt8V1FLnuSrTUxbhMXOpUvxTXoPEOxlp+c+O+u6poIc?=
 =?us-ascii?Q?d57QirXajfaTyfirLoO3w2dChsuqg8kDsIfwnWCCqpuFoqX/tXW1sng3enAr?=
 =?us-ascii?Q?A6p2w6pKXCOfCapR0gsLKRQC418eWQvJGjEiu9UhtZA4skFjxF0GpCIX13N3?=
 =?us-ascii?Q?pl1KLeOW7pk7IFggq3dVtTh/wRyZ/+iR6md3WVbfnBeAhQCy9F6UrKCer+Ql?=
 =?us-ascii?Q?ICcDZwe/0ThyhBt6TEinEj7w1ZZ0LLeLI500nsGezfwkHcuXkp/l8tpxC6U2?=
 =?us-ascii?Q?ipoxHjuK6Pagi0fwTVvkGksMxGuS5VNzxEHbzGxfIb3ITZHpstmcksgZteQ0?=
 =?us-ascii?Q?d3fZiNCpHusi1cNdh3XoyC2bSvuWBrUU86Ep1ExW/U2QgV6rtXZFEzF+ogia?=
 =?us-ascii?Q?p0tPE2AA4nzvJsaGQX/Yy6jD+63gIlV6n+jGzfBKO2ouGkX9hxx4GHAMf3hi?=
 =?us-ascii?Q?CPpyAiO0ry9j1xFgyT7CAbPtfljQFw4GsjMYjWMXtdgPrWqZ4H0zWTHbZiMw?=
 =?us-ascii?Q?/X+OMUa3b7eNRyoS1q2lx1z3oW9pcGkSk1v204mXIdsj1G8r2HzCuSkWJ3QG?=
 =?us-ascii?Q?Gl6J8HLAVBRESDiTV6g6QDdq/r+Dz3xPSI43OlGQOmcXWHSFk4c1GORT0e0L?=
 =?us-ascii?Q?zAafCRrThFH3hUQ5aZll8Hiveoh+4fQ9sAbPN4jsxEwLYIBKVR2wQ2Apy8in?=
 =?us-ascii?Q?A1X3yUWGecBwQG9qyyg90cFmxcTUypwFvDl891a0l+8RjuFo1/PAeVb+55eb?=
 =?us-ascii?Q?t4XO86oaFb2r3d4B655wG/S735DAPFK0DcfHN45djELDRHthcM0A2re4uS4a?=
 =?us-ascii?Q?W0ajBP3FMgWTqjRRF8mp/2Ais0VQLie5DPjRPuUjjilKvPPx7pq03LqYj+NP?=
 =?us-ascii?Q?RIMl62vmLLPpas8Cib2PCM5vp8mhTnUYzl+s3w9FK5nY8zQSoE/psoHn4WMm?=
 =?us-ascii?Q?VAJzuuZdqtxdGETnEE/qXeKgpnsUseByDS8uqsHNt3LmuKbGOttiqrEc7BPI?=
 =?us-ascii?Q?sNVs51nTDykUr/QobykOuR38YJErjEhs4SAPB0hyhpXFYPtf3MtxtvcfFKrj?=
 =?us-ascii?Q?vro3a14FH0hn06t7WkHRdsg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mPOU8Le8sNiRH7tFJPGIa/JoQhTbq6CVDfxlVo5BuO3qzuOYlhb4jca/Xql?=
 =?us-ascii?Q?sKu2e/rKvpqtggT0iKO6oCAdldeyWZbuB9XJkUae28glLU/6fuzEmaoBg65U?=
 =?us-ascii?Q?C8AIvlHauB6b9yBLVVUDqv+FDPhS5JoWXKU0j99zjIjO7c/HeegPHmPn0B8A?=
 =?us-ascii?Q?0kUlP0R6TWmr73KQxELWRTpAX/lVyjmKLCO/JAzrxzVf2wSPBYtB6Etk0NVc?=
 =?us-ascii?Q?nxxMAs5FzmWm30Gp31KEGiMsg8hbHn5J00PQwCP32abmW4hOXe1Qhx+Ys6Xi?=
 =?us-ascii?Q?fKebGRodsiC3r6wr+jtdLi3mQqsQe/GhBs4voXqg7A3uWCBHxPNzFwVJkS/w?=
 =?us-ascii?Q?8G62F9xC1UCIO7+gfddqThcEm/0J6TF5ASxRBlKnut6FImWU5AKMR4casnMn?=
 =?us-ascii?Q?KtGldAh3rZSYP2cYRgtejvmz42CknPtJQ/0Yg148A0RA5/VVF8mNkUTHknfO?=
 =?us-ascii?Q?b8quw2bxpLf+F0zuIOELyvQivvwRTlFSg3XSY6xc/vHuTMhVBncQSpJBMM0L?=
 =?us-ascii?Q?RrfHQDqwNjB6yd15lF3UUzKrLO/WokeyjPKCZ75maEgB2OfkG0YzhbGscniY?=
 =?us-ascii?Q?zBjJAkfF5USJkst8Pgm6OiOIs7g/mxuRuIWMA4+XHcBz5DN2TKd5Qyw8ooIp?=
 =?us-ascii?Q?FO3PH/RMTwq+ksXu/8L91m97guU51i/KQaqD5MvckZcYpgcNGKYNW57fJyHh?=
 =?us-ascii?Q?JGK2kXIMjsMh81xsvcD2aWEBrBQG0r2ITfX+wQPjlQFwIpOliIITUE94Sd56?=
 =?us-ascii?Q?HBYMYrLpeKmkw0LCny2X3ZgaRb3tgc+rJihoQ6XJszegxoTsMvpAefS0QdKo?=
 =?us-ascii?Q?d+cU3meDRrE6UX1fWHVsTxXABJujGUrpXtuK2QqS5/iK+TN8w5hPo7zlSiAd?=
 =?us-ascii?Q?GjEhC/nwYWb1tLc7QaDWj52z/gO025+v00rWd4wkmclz6SVG/DDVeQosgTQw?=
 =?us-ascii?Q?rEfr2veC1OzvyHvenzVlD/sIBjaUmsJmSIXUitHYSyoPcxkPvn1ZgzyameR5?=
 =?us-ascii?Q?yVuhIPHWUhOPd7Yu6yPlH76Z2eDLJqvZnTR0IGmAq2TSZwdc2GgmB1wMuPwt?=
 =?us-ascii?Q?xCzgFdZY6QJzskbCdvUY/qKiheeXTBddWZCwFJd37fU6SRUw0vrCg73sOB+9?=
 =?us-ascii?Q?W0ZC9qMdqgqdsaDEWOcAHnUZ30XdMYQudhgfR3mymEgs0UBYkHlK5OSN2/V8?=
 =?us-ascii?Q?aw+L/JOY6p9vth5o1N6SKFLfJ6QnC2lMPtB54nRmREl+VcA5WHqcXdAMfaAM?=
 =?us-ascii?Q?aXEYOQoSEAGDFYNCTrnyOg6kAaz7Ntb0nWKVG1KVWPukCgePbZ3+hg3HQKtC?=
 =?us-ascii?Q?LYqoyUBvflbTbUlBV+STHbJx7W5JOq+ra9ZFWtfZDnt0O0b/pF6UvwEWKITV?=
 =?us-ascii?Q?O3ZKn40lHoWNr7k0u4gFFMxCnPU1VLfP+1WSB8y1FzMGtEJ4eldpE8XutE21?=
 =?us-ascii?Q?mKY3arMgVlm479Vh/5hqv38wR2Fr1g04+sk9IMJWqNGsaqJ9sLVibI5lVTAK?=
 =?us-ascii?Q?u9PMTmmiWHZZBXEZCki57BCoCevaOMdJGSI+G78sdqW8XBNAn4wWluRy2X1D?=
 =?us-ascii?Q?VrZPz+b8yPIrd2V5L3F/wUGYSOHoeFfy8nqnPk1VgdjkAsmy8RYB264JI74+?=
 =?us-ascii?Q?NGB58jg7i08n5UqGHcOqFTrkl8Wjd3xbpn0r9l5dqaUI3dLvUea/kU95dhNa?=
 =?us-ascii?Q?ZNdnxBimcH7X9n7E8aAQtEUPX+6/HMJ0VKNzpnL8hqeOhVTuZBBr5YKqMF7t?=
 =?us-ascii?Q?jjXzBeH5Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8dc921-36d6-4a19-b627-08de6016bc62
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:46:30.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+eBf/XcNkzIt5+00+ZlRTyjMGZVXj8RaEYm/rRC8tGyhICLkCyHIjlN3zGx7/CtgEFYOy3wEb9zZWfBVCx0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8625-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 6135ABC2F2
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:45PM +0530, Sai Sree Kartheek Adivi wrote:
> Relocate the ring management functions such as push, pop, and reset
> from k3-udma.c to k3-udma-common.c file. These operations are
> common across multiple K3 UDMA variants and will be reused by
> future implementations like K3 UDMA v2.
>
> No functional changes intended.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ti/k3-udma-common.c | 103 ++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c        | 100 -------------------------------
>  drivers/dma/ti/k3-udma.h        |   4 ++
>  3 files changed, 107 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index 9cb35759c70bb..4dcf986f84d87 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -1239,5 +1239,108 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
>  }
>  EXPORT_SYMBOL_GPL(udma_desc_pre_callback);
>
> +int udma_push_to_ring(struct udma_chan *uc, int idx)
> +{
> +	struct udma_desc *d = uc->desc;
> +	struct k3_ring *ring = NULL;
> +	dma_addr_t paddr;
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		ring = uc->rflow->fd_ring;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +	case DMA_MEM_TO_MEM:
> +		ring = uc->tchan->t_ring;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
> +	if (idx == -1) {
> +		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
> +	} else {
> +		paddr = udma_curr_cppi5_desc_paddr(d, idx);
> +
> +		wmb(); /* Ensure that writes are not moved over this point */
> +	}
> +
> +	return k3_ringacc_ring_push(ring, &paddr);
> +}
> +EXPORT_SYMBOL_GPL(udma_push_to_ring);
> +
> +int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
> +{
> +	struct k3_ring *ring = NULL;
> +	int ret;
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		ring = uc->rflow->r_ring;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +	case DMA_MEM_TO_MEM:
> +		ring = uc->tchan->tc_ring;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	ret = k3_ringacc_ring_pop(ring, addr);
> +	if (ret)
> +		return ret;
> +
> +	rmb(); /* Ensure that reads are not moved before this point */
> +
> +	/* Teardown completion */
> +	if (cppi5_desc_is_tdcm(*addr))
> +		return 0;
> +
> +	/* Check for flush descriptor */
> +	if (udma_desc_is_rx_flush(uc, *addr))
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(udma_pop_from_ring);
> +
> +void udma_reset_rings(struct udma_chan *uc)
> +{
> +	struct k3_ring *ring1 = NULL;
> +	struct k3_ring *ring2 = NULL;
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		if (uc->rchan) {
> +			ring1 = uc->rflow->fd_ring;
> +			ring2 = uc->rflow->r_ring;
> +		}
> +		break;
> +	case DMA_MEM_TO_DEV:
> +	case DMA_MEM_TO_MEM:
> +		if (uc->tchan) {
> +			ring1 = uc->tchan->t_ring;
> +			ring2 = uc->tchan->tc_ring;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ring1)
> +		k3_ringacc_ring_reset_dma(ring1,
> +					  k3_ringacc_ring_get_occ(ring1));
> +	if (ring2)
> +		k3_ringacc_ring_reset(ring2);
> +
> +	/* make sure we are not leaking memory by stalled descriptor */
> +	if (uc->terminated_desc) {
> +		udma_desc_free(&uc->terminated_desc->vd);
> +		uc->terminated_desc = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_reset_rings);
> +
>  MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 0a1291829611f..214a1ca1e1776 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -174,106 +174,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
>  	return false;
>  }
>
> -static int udma_push_to_ring(struct udma_chan *uc, int idx)
> -{
> -	struct udma_desc *d = uc->desc;
> -	struct k3_ring *ring = NULL;
> -	dma_addr_t paddr;
> -
> -	switch (uc->config.dir) {
> -	case DMA_DEV_TO_MEM:
> -		ring = uc->rflow->fd_ring;
> -		break;
> -	case DMA_MEM_TO_DEV:
> -	case DMA_MEM_TO_MEM:
> -		ring = uc->tchan->t_ring;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
> -	if (idx == -1) {
> -		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
> -	} else {
> -		paddr = udma_curr_cppi5_desc_paddr(d, idx);
> -
> -		wmb(); /* Ensure that writes are not moved over this point */
> -	}
> -
> -	return k3_ringacc_ring_push(ring, &paddr);
> -}
> -
> -static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
> -{
> -	struct k3_ring *ring = NULL;
> -	int ret;
> -
> -	switch (uc->config.dir) {
> -	case DMA_DEV_TO_MEM:
> -		ring = uc->rflow->r_ring;
> -		break;
> -	case DMA_MEM_TO_DEV:
> -	case DMA_MEM_TO_MEM:
> -		ring = uc->tchan->tc_ring;
> -		break;
> -	default:
> -		return -ENOENT;
> -	}
> -
> -	ret = k3_ringacc_ring_pop(ring, addr);
> -	if (ret)
> -		return ret;
> -
> -	rmb(); /* Ensure that reads are not moved before this point */
> -
> -	/* Teardown completion */
> -	if (cppi5_desc_is_tdcm(*addr))
> -		return 0;
> -
> -	/* Check for flush descriptor */
> -	if (udma_desc_is_rx_flush(uc, *addr))
> -		return -ENOENT;
> -
> -	return 0;
> -}
> -
> -static void udma_reset_rings(struct udma_chan *uc)
> -{
> -	struct k3_ring *ring1 = NULL;
> -	struct k3_ring *ring2 = NULL;
> -
> -	switch (uc->config.dir) {
> -	case DMA_DEV_TO_MEM:
> -		if (uc->rchan) {
> -			ring1 = uc->rflow->fd_ring;
> -			ring2 = uc->rflow->r_ring;
> -		}
> -		break;
> -	case DMA_MEM_TO_DEV:
> -	case DMA_MEM_TO_MEM:
> -		if (uc->tchan) {
> -			ring1 = uc->tchan->t_ring;
> -			ring2 = uc->tchan->tc_ring;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (ring1)
> -		k3_ringacc_ring_reset_dma(ring1,
> -					  k3_ringacc_ring_get_occ(ring1));
> -	if (ring2)
> -		k3_ringacc_ring_reset(ring2);
> -
> -	/* make sure we are not leaking memory by stalled descriptor */
> -	if (uc->terminated_desc) {
> -		udma_desc_free(&uc->terminated_desc->vd);
> -		uc->terminated_desc = NULL;
> -	}
> -}
> -
>  static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
>  {
>  	if (uc->desc->dir == DMA_DEV_TO_MEM) {
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 7c807bd9e178b..4c6e5b946d5cf 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -610,6 +610,10 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
>  			    struct virt_dma_desc *vd,
>  			    struct dmaengine_result *result);
>
> +int udma_push_to_ring(struct udma_chan *uc, int idx);
> +int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
> +void udma_reset_rings(struct udma_chan *uc);
> +
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> --
> 2.34.1
>

