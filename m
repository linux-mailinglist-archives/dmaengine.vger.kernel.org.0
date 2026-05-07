Return-Path: <dmaengine+bounces-10268-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB4lBrnX/GnxUQAAu9opvQ
	(envelope-from <dmaengine+bounces-10268-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:19:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB84ED554
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B8E1300D6B0
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4745348D;
	Thu,  7 May 2026 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="atBRRUfd"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53780372B23;
	Thu,  7 May 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177969; cv=fail; b=ndyQk9Z/YGlOI2mXdREm5tvM9PMi2GQkGv0PywFNfyiJEVtYodh/UOkA2l5Lx3XdkKt/sF8yBdFwEpwlQoemSjWfdorh87EATzG4mDIXdqacxO8WAYeLFijSS1EbT5eQPfiXZPrn5Gpo+/YKa2pHoULB8n2nlk9vMM7+u6PSvGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177969; c=relaxed/simple;
	bh=WxtevakjShfQlAilMBw8KygKTbikHuwsJ4V0cA18V1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OW52WOHZLaKcyUzD2EWGKcKXxTbFkh8pDjWkvUEyiDha2wcDQLOTygdPgxT7PowdazCAlhSlf6DUiTcmeCOmkROjqTkECfxyh3OTENy9TXC6tWsDlVw3qbntPshpEG+1mEwqLJ69Q6mXRTlDOS9KmsO61Z4QNXiTXXpWzPOXncc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=atBRRUfd; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk1XLOsg7N68OM6Dnp2N+J9bqWWXAytOOlixF3lFRb72hxrH++WZNvBa2jXvjELmn3Q9SZGIy2ShZLrDi//0vSteWbIwky7sZCR7jSSYzykR7XMyylA/iF5hQHz40mZJRdBc0pAfnF28MRRtkONZusxNSXWVlZ4GeZ3K2pSbjrIv0i24+r5IDxx0bb7GJSJZx3n46qbojnIA0/HNDuySVYOWpGuiLLF0T5mHcPeN4iKH7tFY8ysvEe8XXh4zhAOPEVMAdUHM6cG9Nc62JVJsDqCK6P+kaoQL3JrhNsOzvsoIyfyEid+aITbCsNhotCqqU/plYOFKRgOvx+2aq9xMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTOEtfb8l6fSo6Ba8rc5XHr3RyowR6yaGYdgZVcDERc=;
 b=qdkItsaq0Wqd1SA9HWWjOe3I3hWWrTjFaBgMUlGQ6SleqIUsAmQbvz8LzDYxUYQ1f13omyk4THOLZRxtoj/zXe2+zmeSPtXKun/KpiHRRtvFEMjD+vcuKFr9VfzSG21aLculUANT1Ga7kg8fqDD38Wfh3camp7ePZFKTBCfSk2Lp//VW68+F1KjWKxd+QPZzkiXochfVYJYQG9gvtMnwfpr9e37N/EqUPb70V4sQPuuG6AgmkeVRQG+VYRd/3IhRjDzL5NgUxSlSjftmwFMq3T8cHzio+DPMmOsBLWmR/4K9MiJnrnhPB/nDcK13eyjLBQCtSmGAt4AZZNeWIwELVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTOEtfb8l6fSo6Ba8rc5XHr3RyowR6yaGYdgZVcDERc=;
 b=atBRRUfdNmMXsGR4lgKVQZt97BVxufyuFfPqeFZTTwHrRIYktxEkeFxZNcIRTrpk6KL/3p4/pkgTWzSJY7NR1p4qZsJDIUKG6/WfW0sxuDQz5ZSDzu8B5W4JQVZU8CTp9uH8AVDM3yLUj8eHRT+8Xpw+xnieTEOduz+7+IOfyaWDTWFk+nWawqqMdflU5saaEiUE4mtTn7aBgL3a5NcQzqZPUGaPAhGmu/Se34D5LfKQbLzvD5rEpWXjvrR/xOw0Wtaou5hg/Cr+gp1UBEbnnKLC4X1/SBz7K5OKTsPs9QOb12QbvMCW/HU/+43xv8x/8342AOfMOMgUL1gJJm3Z/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10606.eurprd04.prod.outlook.com (2603:10a6:150:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:19:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:19:19 +0000
Date: Thu, 7 May 2026 14:19:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Guodong Xu <guodong@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dmaengine: mmp_pdma: add Spacemit K3 support
Message-ID: <afzXoN7IPY3aHK8Q@lizhi-Precision-Tower-5810>
References: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
 <20260507-k3-pdma-v5-3-6b9743038026@linux.spacemit.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-k3-pdma-v5-3-6b9743038026@linux.spacemit.com>
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: c60530af-4069-4d2b-552c-08deac6527e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|56012099003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	49DgkqvkF6rxgQlsikr/2TpJi+gI5N/MjbO6+MIDGe9A3EPeetb5jHH64OXlCPxQQGjQJxJ+R8F63asgPLbX2EhmCGa1/nxQwswOkyGTWOBAXPVQzXNwH2JoqhnmoboYIbP8sXIKAzjMrt1BrIimT6dt0w5Xmk07J9+PyDK9QKlG+BnIMkte66LjYoyvTZep2QXzxAmcSRJfbYglkRt5KFqqUqHdliQ2b0tvT3KE20lOgw8lspWUyFSBwQL61qHwcXbCV4RED+ynz0mWs5ePsyQeUX0luSDX8MwRWg1snQPmqCgTaEZztCBOe+KXMJJemZmz7DZSbiG3somPanDAvzPKpMYQybdF7TPc6/BeDOhfK1W5D86+O/eG8g5Xg7m04CoiE/2Au5+H87Dtj8vuEs7LwdcZzBMmO3WgQ11LcLM1rGtpu23SKmfrR7x2O6JmoyKKd8yZ0RTya5yqJNv82a71niy408txy2PZ1YpoxmJRtQJ2jA8fzYCUCi95/fakPK2hhBK+KEV9UfR0THfnEduHNcSwlKVpHnItB5sQr55Xk8/hBpl+VTw5pchyHIyAsXvWEG4+6VcA9t7/sK+PT5YulocmlVYP3xnG8kP4Xta2XFG+z7QBwdZQ+ctdz6UWW719qCb5tRYNbEM0bV26C27YCE/OgN9v8hzWI/3usFuF+pQbJQi+fAjpKCrlbbwHCd+qmwlEF6zrQ6KD4zTie4dwq82fVXizRbl+IC/buu7838ZV1OpkAxIICMXI7Ll0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(56012099003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3z7Ms1/eZa1e0oaBqjJr+4ip5nbKN7eOla31qtIRrAo55EkZp5RKjoiD26Z?=
 =?us-ascii?Q?INYKJpwqWInZO+Oya8yJ4sLoRUaaXIsxXysUWni4yCLsHCZPv/jJ8xblpDwq?=
 =?us-ascii?Q?80hq+Ap1zqIiwl5MpMGcSUxfI+bWal7nBAT/MjsMy/e1EF2HGyb+5In+JeD7?=
 =?us-ascii?Q?xG2FH2c6GQ7a3XNhls7q6AnAuPDXqoS92Jm0P8AeZk58mOGl5R1hEe4AUawd?=
 =?us-ascii?Q?QD3J+cq35ArAqgwEBix/IXwssFUvtUetKq9ofmdw2aAQdEvihKnWgQklh9iz?=
 =?us-ascii?Q?PznN2ruCkVBgQ6tq0JVcAdFv9qw83jqZyIYXbvdnuI86bnqKnF1HN0TcSIf7?=
 =?us-ascii?Q?c1MDe7nzwRBgHjHbOwhFDoBOjmo+Wg6Y9NG11kcmjLjJZ+cWilcfsmml1sOc?=
 =?us-ascii?Q?kjSMQxNuuMOz0cNUJ76yIemgrukP4WTWOxcTOmSIbOdpxWC142uxOfX0f5u7?=
 =?us-ascii?Q?W4vcZN3nQAFCUMzrI5s/kcPxl5tWi+8ZxCLizFSB+LkVGxOg9+MpmK4ZsYEK?=
 =?us-ascii?Q?lQpoI2M0U4YhMOt6DBL/761Fqw+ulNi5zcx7N2SJnirPK/T69J3Tx/B7mPkv?=
 =?us-ascii?Q?SBKao/SKparvwekMAt+e+CYR/pgyAb/8/IKZ7QChJRpuo/8PN3DuSvRvS72F?=
 =?us-ascii?Q?uX3RYUc6JGJ8ybFjrurmi1VXwo2OH2Yv66DSDwXJ9/C5XDgqNDYnOOj1oeZP?=
 =?us-ascii?Q?kTOel/DNYA8LdtYFG/c3tRUvosIb5xUC6smMbFGL1UYN5vF8IYwv1oJqy6vz?=
 =?us-ascii?Q?yYUX6CpNotyfWxfJU2ADV1h7xCBR06aKWRK3AthCOUOvrRtciNGj4bl4jBxj?=
 =?us-ascii?Q?hrJCKftFovsEf+JL0qkPnmYLGTBjt/s4S0DMHyKniP878M/RPAkojv8QAW8W?=
 =?us-ascii?Q?f1aIeyeO1satJd3FiSR2qnlXQDCVCsK6n5HdFcwwBcf6U/0xaR3Y08iKzlam?=
 =?us-ascii?Q?ND5FfEtOXd5xNJ89DLsdfxlvpkt44H0v0gqbZJ6POvZc1rBBge1j2rYi3fFN?=
 =?us-ascii?Q?TyeMu6L53OE/VMZQAS90rQ/jwSj3HzI7Luhxc/eO7Yr1N0zg44cElk3UujoY?=
 =?us-ascii?Q?S9cbhNUOsnYo4pOvCN4Zidd17/M5tcB2tNjJtQNN9sFpqWTNoUljYWEynd2O?=
 =?us-ascii?Q?EwKcIOskTuDPnIf4J/1rDBVQAALm8Cq+dVrL5qqx1XZDHkwe7l+QOP/u/SPG?=
 =?us-ascii?Q?6cdYYn9KApAKM1mDhoaqpPNgIrnaJRmYZgI/zsK9lNWmIDNQO2dsUXmAyYRv?=
 =?us-ascii?Q?bZY+5WOtMy0bIkm8ybxJWb06vlJxdnhpzt+tsCzc/STWNR1yObpXAdMWUxy5?=
 =?us-ascii?Q?6gKwhO0yF4o240rATVBCvuFaWr1kAOwQfBWEBu796akQvmoqLOT0vwpCV6HF?=
 =?us-ascii?Q?5RtXf2cT1f/12MiY9lTCAQYPiwD9Zvg4WkOufDtgJEEUdUr2i+RrfBbCimlf?=
 =?us-ascii?Q?FjAksVKWJ4pFB1uSkGdLP84uHE0CEWY7CPPbbpZ3FGmSrLgCedQ4ZhoT0Kyd?=
 =?us-ascii?Q?arR/97zv3iCDptx6GUdzfqafxqEgZqwBUW1q3ts0yQLOHBMGOfXkSXLTonVM?=
 =?us-ascii?Q?oU592QGhzS5mR7IEJf4gLlQmCw4tTdq8zeWQ4IY/QQ3cogz8Bwm8OIhQsZe6?=
 =?us-ascii?Q?lJk0GN6tpqk9uqL3uOpBKoXex2PEoAK/8E57U4Yi+mqaBUpdATqRjYNO1oXA?=
 =?us-ascii?Q?ewLfi8bhLMW5BJCJCb739b4Y3ljeee+vRAMsKjI6dacorUhg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60530af-4069-4d2b-552c-08deac6527e7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:19:19.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbFqqd+gg42pomIZlhOhHM3NeStANYNPhEKWGbpno/xqosgvUORC6F/Fd54Wq7Tci6/s5FrS+a0weUEtfFq3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10606
X-Rspamd-Queue-Id: CDAB84ED554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10268-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:email,spacemit.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 06:36:22PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
>
> SpacemiT K3 reuses most of the PDMA IP design found on K1, with one difference
> being the extended DRCMR base address. This patch adds "spacemit,k3-pdma"

Don't use "this patch", just add "spacemit,k3-pdma"

Frank
> compatible string and it defines a new mmp_pdma_ops for k3 pdma.
>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/dma/mmp_pdma.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 6112369006ee..386e85cd4882 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -52,6 +52,7 @@
>  #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
>
>  #define DRCMR_BASE		0x0100
> +#define DRCMR_EXT_BASE_K3	0x1000
>  #define DRCMR_EXT_BASE_DEFAULT	0x1100
>  #define DRCMR_REQ_LIMIT		64
>  #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
> @@ -1207,6 +1208,20 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
>  	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
>  };
>
> +static const struct mmp_pdma_ops spacemit_k3_pdma_ops = {
> +	.write_next_addr = write_next_addr_64,
> +	.read_src_addr = read_src_addr_64,
> +	.read_dst_addr = read_dst_addr_64,
> +	.set_desc_next_addr = set_desc_next_addr_64,
> +	.set_desc_src_addr = set_desc_src_addr_64,
> +	.set_desc_dst_addr = set_desc_dst_addr_64,
> +	.get_desc_src_addr = get_desc_src_addr_64,
> +	.get_desc_dst_addr = get_desc_dst_addr_64,
> +	.run_bits = (DCSR_RUN | DCSR_LPAEEN | DCSR_EORIRQEN | DCSR_EORSTOPEN),
> +	.dma_width = 64,
> +	.drcmr_ext_base = DRCMR_EXT_BASE_K3,
> +};
> +
>  static const struct of_device_id mmp_pdma_dt_ids[] = {
>  	{
>  		.compatible = "marvell,pdma-1.0",
> @@ -1214,6 +1229,9 @@ static const struct of_device_id mmp_pdma_dt_ids[] = {
>  	}, {
>  		.compatible = "spacemit,k1-pdma",
>  		.data = &spacemit_k1_pdma_ops
> +	}, {
> +		.compatible = "spacemit,k3-pdma",
> +		.data = &spacemit_k3_pdma_ops
>  	}, {
>  		/* sentinel */
>  	}
>
> --
> 2.54.0
>

