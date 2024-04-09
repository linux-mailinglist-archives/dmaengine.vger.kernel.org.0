Return-Path: <dmaengine+bounces-1797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD689E4CB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DEF1F23231
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E36158868;
	Tue,  9 Apr 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gOn3AdAh"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2101.outbound.protection.outlook.com [40.107.21.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FC38DC9;
	Tue,  9 Apr 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696968; cv=fail; b=Mkxjlv0kXtjyZ7kor+k+qlVPoi8xS4/7cN4rZ+fkbNtcVj6Y+qRkFLb9kGe+NI6i6/3iheMHT6lksiwX9el1TZUwcK2GM5zgeAwRIrtIhA7CM0EktIOwYnvDV31/iRK+S9/YVCNbCckIkkTVb1apzhXDLELMWhzma/HrxIqEHSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696968; c=relaxed/simple;
	bh=oAMKworDRt11dzlP1OVxcAOYcqXZx/XYGkKIbVk6mR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EX6h2BKu0FAsxLjOMTw1KDi6hsnlkLbhstSjTYbLNaEK8hIR06UdxpMiRmhWpw/OR0OoMrnkgp0R4ydehAUm4swKhcUJDfkeOsMorCJHduD5FKAisGPslX0mBUtaa4oC7massYsLSo7s9i0nbFjQCtzwyDFdQN0iMYsIoPP7NmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gOn3AdAh; arc=fail smtp.client-ip=40.107.21.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV7NEcxYzJxu/qvdR7fjXqiGFXa7g9M9XAluVPWxZeM3MGMAz4pl6WFMTcUIQqbCihhCTLTsGjco3JYois5XxEgpEe8LwPjOJ/44mxYCwIBJpmJ8Oh74WpkAUsoTXw1m+FL2wkWpKsWa2jSJb/g4uPSxRZU0wv1d7Z8fJZ91vJ2cpRBR2IeXuFmEJYTQ4h3bnmusontuhCH3iC0uxScoTYa86Wkm2OL1hRjYQm4tDjjWqRc2umB5e2XWurEV89xHcnowLdpBnWrfTAlrEwd3J8f0hHLfbaKbhvH7klDS4GotqUP5r9oMYbHG4ip08PfOh6UClhCN0w+1vOCuJd3xWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/ynDWqLwLsFT8FQP1CHE3eODVWniy86P+ucBmar7rE=;
 b=lDRp5q1omKCHFTyUHs/rQrDIoX2/YMFzQG+NDUAhwx/pzAUd8h4VQI9Nw7bDDeYde6+oe7ggJni58LtlGHOkNfuD9K0Jui+sRZKsLJCB2kquacgn79bIUr6gaPbeo1E2uAnIYvF0l4wEYUEF8S6cD4CgXlv6DeWkGj2gB52lnNzTEbtjznMYF8dD+LpfCqIQaavC8rFEc2XTM9G+Z2NqM/R31yzxweFAkmmGIAaiGoPB337ZwbLi1LcNoPvWek8NUqHGvZUTp1wSZeUi7aDd/iM62OMAWCV3NDzfDPy+KUK0IeRP8zlGlvZutQ0phuzmI2nGMkjzxobZk4jrvajtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ynDWqLwLsFT8FQP1CHE3eODVWniy86P+ucBmar7rE=;
 b=gOn3AdAhKeNkSL0v/Zs5ERZndiKdWDv8jCl42S2VspmCg1kKnLu4H7Xuh0mo2N57p3trPtATXw4DDtoO89F6pHANOmamji/YjmuJfe+aKiPHPp0OoY8UmFM8K+r4dZsK0DjvU/l/vFLwUAc9UPKX0Vt+agJeJVB5iRFsWQmh1DA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 21:09:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 21:09:21 +0000
Date: Tue, 9 Apr 2024 17:09:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from
 required
Message-ID: <ZhWuetC8bRvDyxgX@lizhi-Precision-Tower-5810>
References: <20240409185416.2224609-1-Frank.Li@nxp.com>
 <b15ad271-037e-4ee3-ad88-e8068d31c8c8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15ad271-037e-4ee3-ad88-e8068d31c8c8@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9HgSZrCXH/Krd+cZtlEK4o3XGv4OaasPJbaYGCWhH8ZdRwRwioeIFqiVBa5vhqkv4xMsffXsTZoqL/cyAMs9e2+h+slfrmiS3oRKLWToWccKNaN3e8M0VR9SvzX2/8daDneUACYBWPCjF7xjrHGCcjenkY+FqKiyK/7fXwpFfev/ymZ388MAAvY7ix1nTER+r/IUCNApnJWszRzj35CLuYNkBUbbBivums8D2TYSpmJ/upANA7YwkTnnANa+UiwZv8nTdpMkKuH7wjuBLV8+lr3Q3loidNyz8zQ4hnKQnSbg1j6jx0twLT4y61QPCVuDxAIv3nGm9hVzSTH1d8o1AbLPCHqIcqvfHRu0+V6sr2aS7DSrdCfMXQAJFIvUNa6rXXiSLnxX56KhW80KCvwQK7qVlSd8KTVFBENsMkG6jSw4bhC2SQu2pOh3ZMrl3euAeqUw0sl23VIduJn9xm2KcTPmn3P5cu561P9JjR+98OARCB/jS34YoiA6ZXShvB5l/Akwtd/MsXE4wdsnE1EKMVK9sTAUkaNs8mSEIXIPvxjZVH6K+G4hFFOS0HWdplV+rDEF7U7Aoj49YKZmxhivr3gWL3WwhrcjvT9HDCad+x3tWJVpSIqzA5PeexXx9xse0Y8UYtl3Th8sA2/tC5NCyXE4+cSd5bcB11F5ZdWGu7+uuoNHh4TAZXkDp9q5q39D/rdRU+YxDqJIxMiaCvCgtrzqVEwOBAUJGvFco8xwbr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plDyUr8EggZ3upl7de4T55lnUavc7BY4w+qB0DtQwViduHFFtb5rLuD/Di9n?=
 =?us-ascii?Q?IpEfUSqH3FLqDvauaAnBnDvMDdqWlfzNcAuT0NndafZ/7dm/eFYzdV/9WHek?=
 =?us-ascii?Q?sEZBmAkne6V2Xtz/MxiqqXweOanQgkkU6zLmIO0Oxd64mQii2G7D85AB79KC?=
 =?us-ascii?Q?CoqHfKDxQ2rYoDP/VSaaIAp+ahPX6sXR91/S+KsFYE0VqvAgvKZf6cYsCpGE?=
 =?us-ascii?Q?KBWU3luuWSr55TkMDED4Hvy6+H1/UNHMG3FioLMCFaumnpzIc1zOsV4wH2MO?=
 =?us-ascii?Q?2kApnmMqE8RxSqqS6P9NYW1SNOhUkKP7z1srImgogQ1a4zaULFo96CfdaYu4?=
 =?us-ascii?Q?4pJOwEu0ZlvWqgKsTxn4JrnUWDai+bqVA41Wmh/oXKIZYGcUvXwikOgF7Zk/?=
 =?us-ascii?Q?SiMSV1+jGpNDw/lMKVd/WcmfKhXdvyQQItfNAGWncHD8KOSZk3cr6iDALB30?=
 =?us-ascii?Q?JV8M68VqGu3l+KnQLdUOcTXBvZpnIe/w3EipjYY+OZmGwuEs11xp2NF42VVO?=
 =?us-ascii?Q?dpWHHl6jEiAjGbHbwteX0xovc+XD9WlD5tcRcDfBeL6dFN0fe8o11+ukUSHF?=
 =?us-ascii?Q?mQLQH3MBNLNAA6TRNjMj/bfLVNjJsqD1q+3BF/4t+aUFeNGvgl+/sog8fgby?=
 =?us-ascii?Q?k1x2ImNgmUbHAecjbLotR/gcXf04yzoPFrsQ6u41Tb3r2u6r2BNZopy2mxM3?=
 =?us-ascii?Q?MpMLGnDku6pHN06ZzoQmsuHjllIVhiBpNyLULumS9I5QNnXqL5zXQgNbldB1?=
 =?us-ascii?Q?by6TCyceJvpepOvI7qaLgZO6I1XFKefuRpjCAnmb/Vwlmf+HoEzcy9DZvIrz?=
 =?us-ascii?Q?WKokKQE8wH2wjOFmHfzrfLhof7okDn8R06dIKjUYfNFGCDYXzvn3LGClhFA8?=
 =?us-ascii?Q?/4lc0yy32eY9yC85hY5lYwv1OlIBtlFvvXVaMQ9I7971yR9jkrPiX2q+2P3M?=
 =?us-ascii?Q?+bq/FWzw7japFjSbklTqIT2IPqeYD05+ATsed1j4BJEtsXZ1o8vFGVcoMP/b?=
 =?us-ascii?Q?MjYuDENdpF17vdAHXVYEziZ9P8cbj6YzDMHM38ATOb8+4wHeRkcV5Skn6fri?=
 =?us-ascii?Q?zBhSIAXPkjYFa3IeuNTlYXPwOCYzFTDF1Vb5xqWAT4fGBuCMOZ8j4osNb4lT?=
 =?us-ascii?Q?OIyqQiSGYouXUAfcJBKEHEK3b8kxXgXtGskNTpRNxkN1WNViou5ZleOMyeLm?=
 =?us-ascii?Q?6bIkvIX3lB4pnlqZRyWVEOnzHuEGEofQLEvrcL2RJA/T8eP00qbNxVF39yzg?=
 =?us-ascii?Q?fYkesP0bG0YitYfQ4dH2lGLMmBwGKPNljrJLyLIc/VlfSL/a0XhPyYnHQzSy?=
 =?us-ascii?Q?QDFdYdE9ZOnVLiTScyrlmCCaPPVujW9/g08ka7mf9H8oxpoC7MmraUz5t6BW?=
 =?us-ascii?Q?ZcWV2DKyl6D7VE375Lp7OSdoD5PldnnhWsoHENs3DlpKxROETUX2Mg8/gv/P?=
 =?us-ascii?Q?upKoI1Kt6hGO+TNMRhqzFiEvEN/tdLwA7s11H6Q3Rd1GD9wnAXOnjT7CUMQT?=
 =?us-ascii?Q?FZEK10X+7UrBQMPeLMM5NH11fRGXwK3U58L51NPv9dY3wLBIxGzv/DS5Gw4u?=
 =?us-ascii?Q?v8OcKNwb0seAeE6Pf+g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe136f2c-050e-492f-4e34-08dc58d953ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 21:09:21.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og21lrFMeAEb1w0BkWiiOIw9ganaN91fujG1vDdFfM5bHT5C72nOewyDmZp+TL/7/9nI2/8Bwzto5hpA+2aWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674

On Tue, Apr 09, 2024 at 10:02:32PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2024 20:54, Frank Li wrote:
> > fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
> > required and add 'if' block for other compatible string to keep the same
> > restrictions.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >       - rebase to dmaengine/next
> 
> This fails...

What's wrong? 

https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index 825f4715499e5..657a7d3ebf857 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -82,7 +82,6 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > -  - clocks
> >    - dma-channels
> >  
> >  allOf:
> > @@ -187,6 +186,22 @@ allOf:
> >          "#dma-cells":
> >            const: 3
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +	  contains:
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

Strange, Test passed

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb


> 
> Best regards,
> Krzysztof
> 

