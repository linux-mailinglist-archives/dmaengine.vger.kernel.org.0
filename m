Return-Path: <dmaengine+bounces-9554-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNvxGvcVvWnG6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9554-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:40:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0702D825D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8870330ABD71
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58E376477;
	Fri, 20 Mar 2026 09:38:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022138.outbound.protection.outlook.com [52.101.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105722E8B64;
	Fri, 20 Mar 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999529; cv=fail; b=F3UiSKmk4sE8UnHGJB66fVAJ9Iq5ycPhs8icenS2sKfWAM146gcAYvuYMMr2Gtl2Wncw9jsu5aLv0c0E7TMtiTKNAYHZN549mT++6hBXk1HYiwBN7pEogZAk7IH0U6nCso4XfseQijixTiJKAuEdLbNa5/nSu1LT2y/rYxEqt1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999529; c=relaxed/simple;
	bh=O6YrVg/VA+FzzFiDnFW4Dab0L+QK2bOoRqWg+A1o1iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCiaSWrpLl7txLWcKgxZojswTBp+m5N/wxAl0HzyYiDf3QkpqLydtQnxTk/IyvHwbzzr7ItTf8gB+IcNE+nuXqGtC5xKYj4HcFT4d3tBe5Ink6uJal/7yLPnrWtetrzDksxkzaxzafAOovWTUZX4H8JiSnAFaEWNbxaLFFfJ0I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZL2a9/Z8uZyLXfzADx7aoqIkP6uBI3nV5weg4RjXaT0CARaPvjsQ6kyatjfScylsObmqsa0pWER/cEAWTa9Hxay9ygpa/gT4eVW4J4cdKEUMbcSZDoYtSutnlo8D3suerhcnEBnCD0ZEGU1bWjXMdP2hM6y4x+h8nXHNVwEH5rUvqFpW1rf9sWXyE1sKfX1x2WrP9cQ6/CzGnnyg1mQIwtEc9pTt+rY/oxG9PUEtXTowC0UAdvVGAUlpwy+hmGDhQHTbNX7LS0I2gJxYjhZ4QXskXqlaqeXiFRoGYHqLt/Cqb+/ErepwCGg4AANnHn28F3iuWjfYluzMuQ8BIZJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+tMuQ6+ijkmWkAGrmAOavH6O40L35Xsog9Lz1Jw6Bk=;
 b=r6zmc9R4vA2DQSVklY75z+gsSwEv08gnlC5QtdRatamff/0u+3DgexDi/b6acSRJpUgEJEsk+2kr3QFJ61RDm+XPsCUDVSuDiBT/zB4fhk7RVcUAj+6cMQgqZzoZDI5qc7UTvdTBpIOwuXX2KTCv6v+vfmHAihozzUrmVns75m5nm0v1c8d7eVl52oxm4bAfLVaVkfbNVnyJL1N4rBHrbW05Iaj8llEb6FPn3p5uyEVr/3ovLgFEJCBU1wPmTK71vbAqJjY850RZPzaDEKkspT3aJNldPe0OfxkVsO/qbhf3FidiQTuUDv2iJM1m4Oef7jWbS0l5c/QR3Cj3hv/UDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12) by
 PUZPR06MB5556.apcprd06.prod.outlook.com (2603:1096:301:e9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.22; Fri, 20 Mar 2026 09:38:44 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::22) by SG2P153CA0025.outlook.office365.com
 (2603:1096:4:c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.13 via Frontend Transport; Fri,
 20 Mar 2026 09:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 09:38:42 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5B5814126F83;
	Fri, 20 Mar 2026 17:38:42 +0800 (CST)
Date: Fri, 20 Mar 2026 17:38:41 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jun Guo <jun.guo@cixtech.com>, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic
 and combined IRQ topologies
Message-ID: <ab0VoTut0u4f7EVr@nchen-desktop>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
 <20260320-vengeful-violet-cockle-382580@quoll>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320-vengeful-violet-cockle-382580@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|PUZPR06MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: dc518283-91c1-4f85-5a2f-08de866479eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OgHYZwojVLXi5GrMG5iwRvMU31kbnXqjNv14ij9OxMCjg+Tg2TV/PTEOav9Sxt0fU1Y6xSHXN28uwtRTxi7THGeDlk3DKNvVXPsuI2dk05YUo4dSfhQTI47LGwsNjbnfTdVqO4iSXz30oIfSgK1V5zy57gCiApdWqQ81DsxXMGf0M4A2t1Qdw8LL3rkN4aR4rpSkonQI9Y3lSXrVvBUy+oKT+KbULQ7Yb3JIvVmMb2qchWhBg9sZ7J/6Yv2pT8s6jc1Tt2JkGMKy69Sk89aF0c0OKguoFJswoYk1yYeWBN5EWSlc+WZIYyUO8CxNJ6hteP7CLTaHvxxL3tlMggcod7aWH0BYWR40tuJILjPT40m/1FJrW9CEj5gxZjX4bl8Ao993hL1ExR3z316XHJQTD6h8prDCs5KchqYfJAEP9k/eZATh10SuTo2X7Mz/DPR2uHSOgQoezs79OI2DabPMnoxEq1NyH6WCXhXSsHQfOn/ha7uha2jT+Hm0mgw1oMfeO7VGCNXqpe2IIGZ0q7WUsOBKS1w6k0BpQXIEy5IB70o9q33QLN3mEW4gGTliieXgMX4+ZBFOpm1JENOkHzLuYKM4u40eNWrnnX5SMDGAPqRjgDL/Mp78cKAgez1ygeFGNJ3LBxlCZ3RYbyQfcJ6SPwo3AA5aq1gdtYbVy7upm+b89BLaM6Wsr1fkEQ+YNycB5E5sgtfkIDjuMvnh2XJtF02PCP0GBsKUx8DZzuLdZg68djPbX/t8Gf8F//mfQTF83UWbPkcBZk2XaxDvMzULPg==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uTudb2ZJsafzrlw6fFZ5JtRo/biQTGgJCqsOKo8HcWR6eoULSaW17TgLG6zBYedSfhkaK/lMrHYpWkwcY2Qf7Jd8xs3M/10Egpx3Z9ycQ25kt7ESY5O7MkVt7IzfmYg8TzGOkALM7LZG7dXInSog9ZHnCy+Prx/4AnoYPZhquu2JVyndxbWordGjZ/aWCrSNveR7EVv+YhzBHDmm1aor27GgaviJf3tXMuFsb/k3YmMN1qKxpd9vhCwF3i1LCnVnw60p7DUjtr1PppED8jZ5+Os/xWrWcPTQulAHPQ7685CSLVMe5zoUXZ7uQIrGxz+QtS5sxnkUte25lXE/DKCiR1CGmnNdH1C3Ee7PzhuNbj45tGwpU/42NTRMAZkcGeytfuUh/Ock6ufZ3SQAZe2Z7aEks+kp+vK6x6q3jwKbg3dPSwcZu33sJuXttCqrdtGT
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:38:42.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc518283-91c1-4f85-5a2f-08de866479eb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5556
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9554-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.166];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@cixtech.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE0702D825D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-20 10:12:53, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
> > Update the DMA-350 DT binding to match the current driver behavior.
> >
> > Allow both:
> > - "arm,dma-350" as the generic compatible, and
> > - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
> >
> > Also document interrupt topology variants supported by hardware
> > integration:
> > - one combined interrupt for all channels, or
> > - one interrupt per channel (up to 8 channels).
> >
> > This patch is Assisted-by: Cursor: GPT-5.3 Codex.
> 
> Wrong tag, please read carefully the guideline before using LLM tools.
> 

Hi Krzysztof,

It is the trade off for coding-assistants.rst suggestion and
passing checkpatch.pl. Currently, checkpatch.pl reports the
error for tag without email address. So we choose to add tag
description at patch context.

Peter

> >
> > Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> > Link: https://lore.kernel.org/r/20251216123026.3519923-2-jun.guo@cixtech.com
> 
> What does this express? Changelog link? Then keep it in the changelog
> --- part.
> 
> 
> > ---
> >  .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > index 429f682f15d8..3639ce0d5054 100644
> > --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > @@ -14,7 +14,11 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: arm,dma-350
> > +    oneOf:
> > +      - const: arm,dma-350
> > +      - items:
> > +          - const: cix,sky1-dma-350
> > +          - const: arm,dma-350
> >
> >    reg:
> >      items:
> > @@ -22,15 +26,22 @@ properties:
> >
> >    interrupts:
> >      minItems: 1
> > -    items:
> > -      - description: Channel 0 interrupt
> > -      - description: Channel 1 interrupt
> > -      - description: Channel 2 interrupt
> > -      - description: Channel 3 interrupt
> > -      - description: Channel 4 interrupt
> > -      - description: Channel 5 interrupt
> > -      - description: Channel 6 interrupt
> > -      - description: Channel 7 interrupt
> > +    maxItems: 8
> > +    description: |
> > +      The DMA controller may be configured with separate interrupts for each channel,
> > +      or with a single combined interrupt for all channels, depending on the SoC integration.
> 
> And more important - you must review the LLM microslop output before
> posting and adjust it to Linux kernel coding style. Don't send
> unredacted tool output.
> 
> Best regards,
> Krzysztof
> 

-- 

Best regards,
Peter

