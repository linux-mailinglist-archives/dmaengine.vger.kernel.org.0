Return-Path: <dmaengine+bounces-1447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8D8805E0
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9595D1C22785
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599654BEA;
	Tue, 19 Mar 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KW6RboEG"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5C54665;
	Tue, 19 Mar 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879147; cv=fail; b=TEU3zwzD0rIrX5gNm+bJoeKwTznJ/JhacdFLx49UNlXSVLmORAoyrb58Pt2WWzswEbR4D8vJkbujHE+1eSPZkDv46eNWY6ZpEKGO50EKK33WZikCR5yBNSNqJQtOMtOHBR4j29riG3G5RN9NPoq57sqV/rEOD3G4E1/ZwG9DHKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879147; c=relaxed/simple;
	bh=2wHfEIl9YPecdOFEiJDprXiE/YjRG1DwWhs5+4wHtbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tD7FEBdzqWoynvJdSnN07+4BycGvTbgZgLrU1oLLMOvVtFpHdu0ToSCkhosZvECTPGJ1mBi3r73dyCUqcYuPVdsGTrr8AzHTEAmli/hvgFq20V5eUhVh4q6xz7Ej1A+NALV2fgaZD3Rkcdd1yZlZ/wDSfVb+sP2+HbYmcrG+bXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KW6RboEG; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+Pa8uy1zP3En5RVUxOirPZFW7D5W7/7TmrBOCTJ+KhJa7MHbHpigzWqQDn77Y5xiGQPw3PL00XALh10VGY7xUFqoZUeRSXrBzGXbJVQcxW21s97uRLVl2+NDDX2V0Nu+a379hkypVMvsUp48QYGInu22r1+FsM8lqyQV2UeEW3GEbtygyOEa+C0mTF+uGCTHJI7v0lKNZumK8yq1u+JhE/OJiwVR5J++rlQAMZDTxYKaFvoO+InS0ONpaSpEWleO8PCMhvZf1n4ECTQZB45hk5MKT3GOFyX+0gwqeZPsg+3uNlGHp/sCNnO5rXwCmR90peDCH050Fy8B0kWkxaN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpGyRlFoDQt4SCYYVlsimfBB14SIiX8l/jxFrBLLpnI=;
 b=bYd7LhBIZDNBErJPIoUxj7BgT2vYmSEfenyfcFsyjhPx8hftrfQl4Zyy3iR8cLdpFg5Kpw2xSgrvzsTIpXePlzf0xBuNZtH7j9gvhrUREhOxVedaHeBZA3yZ7PWa/+1DDMcXE9v6RhRFCgvZKO764Th3YjwUFeTbiz8t3Xk5ATI6AmI3azVsuX7emVH9DZRqSrzygqZ92KkrEme892BXgRaraD6vKgXcGBPTfNT7xJ6XSWzpLUnHbiO+XdCpO47IGe1AbyEs/VjLoP9v28e05jYmFruYd/aMNIWucR8lR4mC7CJiRfTc9YeSrabJD/Hf8KnecAmJTRvOmHZaWGhncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpGyRlFoDQt4SCYYVlsimfBB14SIiX8l/jxFrBLLpnI=;
 b=KW6RboEGLAFcyZuXUmk/vUW1FX6dqWTeM6t5fdVt6PEbOqoGRNeDqv6JWHdb3Gw9BKym8/j6EmuUYYi6KKv1t9xxuLlWT/OhbeJ39Q1i/9dlzIJblhBCMR+wNG+Dlbqtik1tt4cxZdQDo7sVwPwLr4CF6uQRtSiC5h5usyGn+/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 20:12:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:12:21 +0000
Date: Tue, 19 Mar 2024 16:12:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <ZfnxnGCK+L6UcLE7@lizhi-Precision-Tower-5810>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
 <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
 <20240304164423.GA626742-robh@kernel.org>
 <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
 <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
 <Ze5ustkOPNYpXubj@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze5ustkOPNYpXubj@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 29971575-1b2d-4f1b-2720-08dc4850e240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZTYZs3/p3VuVeBXXsh1LmUpx0QsodQVDU6bxVYq8+PkoG1hlnrbVrpUpnTIPTk84+VPn4eEA9ldYikqwVBqYQU4urIhU5/KgBYg4ilUkn4DxCbHKzUTxgEqMvC5TB92GUBKm59POKZnYcWQnxyw5QmzmprUP1/9pneC+zpmVZWH2bPtwbqHFdkKfL2ARSu59hgjObcX0m8XAg7IKuWsgw52gNpCzqUYmO3YeDXxBmvqD7sgfnUCDXa9h8eLvQsyS2EtOQSHFdprJDrBcdwIB5qTU2liRMcCKFmqLq26JzMlKIFf13NDGVyqhvzakNVr/NkJbcp6U/8TQ4v98bmWea7V21uCRReTe0Pfw29yQ4+dDJTjuKfBD1YiDzxf4ERVBWt+Wi5r1C1+F/v4kw3/UrF7c+K+7xCQdX0rUHb/7W86rGPgrPvpg53gPc8SqO8nvTjWyzZbUi6ibWOpy6c6Xw5ztYSxyfCd6fcs/MJXQ08QwC5ZCPwiUmdTAGs5y8zMtTlvhFwl258R44mnr8ASlfiaRgOb6DB28fyGdRUx/0w0qf/YlvfHSjg86loFLoXLn2uuFbbNh6GAOTiwY0aQPI3EBC2Mw5j5DunIzGdnio5LVmuekUdWJJODFSBJbtd8O5CwmKTb74/BQWT12zPsvBAmWgU9wNZQodX7g2eVDHw6rDLV0iw0u7P1I4PlvR0RlSAR7y6MtpG5ppbMsCzfDOo8ll78dqYfiOxEnJ+nCjpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkovRnM2b3lrOHpVM3MxMHVpK25pOUZya2x6a0kycEt4M0FZZ2puTDVFdEVn?=
 =?utf-8?B?TVBSSmpiVVF4K2JqMC8vL2ZHUmE5ZUo5dWlEYTRxOWZZWGxhamgyVm1hUDlG?=
 =?utf-8?B?ck50eERiODhkbHNjMHN5MlQxSDdVOTBZanhkeXN2YkRZWFJPcThzZzFHWUxu?=
 =?utf-8?B?ZEFVNk9wOVBGTnVLQ092WUhxVDJiVjF6MGkxNEZTRmgzYjE2SVpQbHdsMTNs?=
 =?utf-8?B?ZDFBaEFFU1I3MlZXWjRYa3o3eFNmU1hiWFZnWGZSc0FqOU5QTmpINHZGMC9C?=
 =?utf-8?B?ZFpIWHBqcE5PdklPN2JseWZqRkEyeGtvN1NJajQvaGkreExMajBURytYRjgr?=
 =?utf-8?B?SEVOajlJTzhWRGdJYU5lNXJYckxUbkZhdmYwSHZiUU9pQXV3WTVMQWplMmNl?=
 =?utf-8?B?aTZoY3Y1aTRiTUhIaTNGYldPNW9iYmE3Y3pDQXE0UnQ3SmM1VGhKeEc4WXNU?=
 =?utf-8?B?R0twVmd1djl0SWhFTVUzK3VrYy9NdzJTeTZjU2NGMXBIblhQTU4yelp6dUNJ?=
 =?utf-8?B?T0ZwUXNjM0dMUFBUaU5jOSs2c1U3bjhTZURrdkNyR2NrNDdsdGZJdkVJUTd6?=
 =?utf-8?B?TElRcWFNTTRQUjgrcENVRVVHa2Y4dzlvU2dFc2cwYUsvZTJpYW9LSWNPOWZ4?=
 =?utf-8?B?SThSaW8zNGhpU0NHaWtSMDdNR3NGdFNTRVlyRXRhcHZYTklSVFk3L3M5dGZI?=
 =?utf-8?B?UkVjUk1qRmIrcTRPRDI4OHZYd2QzZHhSMVROYWhpbmFQUmFvMWFISTB2a3ln?=
 =?utf-8?B?Y1Nackl6ck9DMC90REVRK0ZTdDBTanpKaTFqL3U3b2dVZTF3d0tQK3U4cjFa?=
 =?utf-8?B?dk5SOW1UMm9KeXZtNGtRejlFK29rdUFsOHRUY2ViMVlhTzVSTThmOHpvNmNL?=
 =?utf-8?B?OVF2Z0hmeGpEM2F5UkQ2WGxwWUNWb1FuVXIrQ2lKMTg0OGUxV3QrMkJCbmcr?=
 =?utf-8?B?TkZnUTE0aGZhVG52MEFlZVc0Z2dhbjREeU5iU2Y3SnBTd0RBWjdkRjFia1Q3?=
 =?utf-8?B?MnBpOEVqNGVtbmZQVUhScS8vRUlrT2NTWlh0RVJGamdBdTh4VnkvazRGckx1?=
 =?utf-8?B?UkdTSUJxWFFrNHpXU2lSZzlhVVFnZkRkeTBHejlwbFh5ZWplckxnWWtlcGVV?=
 =?utf-8?B?Q3lYQXZpSEhOV2VRclhLRjN4ZEZQTnlDOEhWVWp4M1drMnlBU2ptU0FiYTF3?=
 =?utf-8?B?elg1KzdIR0k5Y21LWUgzTjkvRy9vZjAwaGNlTThtbXFGQ1BnRENydmhmSUNj?=
 =?utf-8?B?RURhSkNJRU5wMW5BMWs1blpXTXI2UDNJT01iR2x5OGl1b0VxZFdQTkg0WjB4?=
 =?utf-8?B?b1B2ck84OFZZaHgvME4xZWpSNTF6M2RhKyszTml2YnowTWNMay9HNEliT291?=
 =?utf-8?B?bjhHMWRZRXdmR211NVpGZlpBMnNrd0pjQkVFRmtiN1J0SWNnamdkRnE0bXor?=
 =?utf-8?B?djJLeFZJNDFqVXhDRUN1QmFEd3FJcHhvdGpTRkFDcEJxaGlqZTZWZHZBYVE5?=
 =?utf-8?B?enVpV0gvWUpvN3E4ems4dFlna29jSEJ3Yjg0K2dCSThXcEpjQk9NRkVoMHM2?=
 =?utf-8?B?dXpRYXhKNkFMbTAxQ1NFenRQemE5TWNFOU0zZEdvR0dwcVRRSGZMUHVSQ1c3?=
 =?utf-8?B?dWlaWHBiNU9GektpWWlSNFRTdllIbmNmUVlTeVlSSGxNVVB4UVJrbDRPeFc0?=
 =?utf-8?B?YWplcWw3WmhnTkxNekwyNTB4VzIraTlGWEM2U3pLR3R0TTZqU3lUTXI0Mkc1?=
 =?utf-8?B?elRCR1FOY1FVSzYzeHhJZUFZY2F2NCt6b3VVcDBRYnhCMDVMSzV3dUpBelNC?=
 =?utf-8?B?R0FnMHFXd0hKZ2FsSDVqT0ZEdWNqL3pUc0RvdGFuYUZYMTNFWFJIY0xsVFYv?=
 =?utf-8?B?LzlraWYvQlk4ZlhFdUZ0V1JPZ1JlU1NpTXNLaTQvSkFLb0MyY1hvVTgzRStE?=
 =?utf-8?B?MERPaGM4MXlXdVJqRC85SThXNjE5RjZCSWxhTGRNeklTUjdidlE2OC9DT21Q?=
 =?utf-8?B?S09SanRwY25JNDNzVTM0ejJGRTZ1SnZKd1dlRllNeEo2VFlub1JrOUNTUStu?=
 =?utf-8?B?cWZTSUloOGFQRlQ2amxwVUw5d3BUaWw1NjNFcU1LdVEwRW8zWEdQSHdtcFRN?=
 =?utf-8?Q?fICoUnnQbMCCbG+nU19B2U1J9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29971575-1b2d-4f1b-2720-08dc4850e240
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:12:21.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l99RqUk6uFeiz3Q9SCSRVaulXZNWprieUYbnBgFvqCkaxaXWtSNmx0i8JFbfcnZEBTH7yyucLLBqtG/lWp6B3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

On Sun, Mar 10, 2024 at 10:38:42PM -0400, Frank Li wrote:
> On Wed, Mar 06, 2024 at 02:40:23PM -0600, Rob Herring wrote:
> > On Mon, Mar 4, 2024 at 5:31 PM Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Mon, Mar 04, 2024 at 10:44:23AM -0600, Rob Herring wrote:
> > > > On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> > > > > From: Joy Zou <joy.zou@nxp.com>
> > > > >
> > > > > Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> > > > > the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> > > > > eDMA architecture features one clock for each DMA channel and an additional
> > > > > clock for the core controller. Given a maximum of 32 DMA channels, the
> > > > > maximum clock number consequently increases to 33.
> > > > >
> > > > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
> > > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > > index aa51d278cb67b..55cce79c759f8 100644
> > > > > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > > @@ -23,6 +23,7 @@ properties:
> > > > >            - fsl,imx7ulp-edma
> > > > >            - fsl,imx8qm-adma
> > > > >            - fsl,imx8qm-edma
> > > > > +          - fsl,imx8ulp-edma
> > > > >            - fsl,imx93-edma3
> > > > >            - fsl,imx93-edma4
> > > > >            - fsl,imx95-edma5
> > > > > @@ -53,11 +54,11 @@ properties:
> > > > >
> > > > >    clocks:
> > > > >      minItems: 1
> > > > > -    maxItems: 2
> > > > > +    maxItems: 33
> > > > >
> > > > >    clock-names:
> > > > >      minItems: 1
> > > > > -    maxItems: 2
> > > > > +    maxItems: 33
> > > > >
> > > > >    big-endian:
> > > > >      description: |
> > > > > @@ -108,6 +109,7 @@ allOf:
> > > > >        properties:
> > > > >          clocks:
> > > > >            minItems: 2
> > > > > +          maxItems: 2
> > > > >          clock-names:
> > > > >            items:
> > > > >              - const: dmamux0
> > > > > @@ -136,6 +138,7 @@ allOf:
> > > > >        properties:
> > > > >          clock:
> > > > >            minItems: 2
> > > > > +          maxItems: 2
> > > > >          clock-names:
> > > > >            items:
> > > > >              - const: dma
> > > > > @@ -151,6 +154,25 @@ allOf:
> > > > >          dma-channels:
> > > > >            const: 32
> > > > >
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: fsl,imx8ulp-edma
> > > > > +    then:
> > > > > +      properties:
> > > > > +        clock:
> > > >
> > > > clocks
> > > >
> > > > > +          maxItems: 33
> > > >
> > > > That is already the max. I think you want 'minItems: 33' here.
> > > >
> > > > > +        clock-names:
> > > > > +          items:
> > > > > +            - const: dma
> > > > > +            - pattern: "^CH[0-31]-clk$"
> > > >
> > > > '-clk' is redundant. [0-31] is not how you do a range of numbers with
> > > > regex.
> > > >
> > > > This doesn't cover clocks 3-33. Not a great way to express in
> > > > json-schema, but this should do it:
> > > >
> > > > allOf:
> > > >   - items:
> > > >       - const: dma
> > > >   - items:
> > > >       oneOf:
> > > >         - const: dma
> > > >         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"
> > >
> > > I understand pattern is wrong. But I don't understand why need 'allOf'.
> > 
> > The first 'items' says the 1st entry must be 'dma'. (It might need a
> > 'maxItems: 33' too now that I look at it.) The 2nd 'items' says all
> > entries must be either 'dma' or the CHn pattern.
> 
> After dig into dt_scheme and json scheme, I start understand what your
> means.
> 
> "clock-names": {                                   
>     "minItems": 33,                                
>     "allOf": [                                     
>          {                                          
>             "items": [                             
>                  {                                  
>                      "const": "dma"                 
>                  }                                  
>             ],                                     
>             "maxItems": 33, 
>             ^^^^^^^^
>       Here need a maxItem 33 and make sure first item is "dma" and total
> array is 33.                       
> 
>             "type": "array",                       
>             "minItems": 1                          
>          },                                         
>          {                                          
>             "items": {                             
>             "oneOf": [                         
>                  {                              
>                       "const": "dma"             
>                  },                             
>                  {                              
>                        "pattern": "^ch(0[0-9]|[1-2][0-9]|3[01])$"
>                  }                              
>                  ]                                  
>             },                                     
>             "type": "array"                        
>          }                                          
>     ]                                              
> }
> 
> The yaml source is
> 
>           allOf:                                                           
>             - items:                                                       
>                 - const: dma                                               
>               maxItems: 33                                                 
>             - items:                                                       
>                 oneOf:                                                     
>                   - const: dma                                             
>                   - pattern: "^ch(0[0-9]|[1-2][0-9]|3[01])$"
> 
> 
> But unfortunately, 
> 
> dtschema/meta-schemas/items.yaml
> 
>     type: object                                                         
>       properties:                                                          
>         items:                                                             
>           type: array                                                      
>         additionalItems: false                                             
>       required:                                                            
>         - items                                                            
>         - maxItems                                                         
>     then:                                                                  
>       description: '"maxItems" is not needed with an "items" list'         
>       not:                                                                 
>         required:                                                          
>           - maxItem
> 
> 
> dt_binding check will complain
> 	'"maxItems" is not needed with an "items" list'
> 
> 
> I am not sure how to go futher. Maybe below 'stupid' method is less impact.
> 
> items
>   - const: dma
>   - const: ch00
>   ...
>   - const: ch31
> 	  
> 
> Frank

@rob:

       I can't found out a way to to handle this case. 
dtschema/meta-schemas/items.yaml not allow 'maxItems' for 'items'.

       Any suggestion?

Frank

> 
> > 
> > > 8ulp need clock 'dma" and "ch*". I think
> > >
> > > items:
> > >     - const: dma
> > >     - pattern: "^CH[0-31]-clk$"
> > >
> > > should be enough.
> > 
> > If it was, then I would not have said anything. If you don't believe
> > me see if this passes validation:
> > 
> > clock-names = "dma", "CH0", "foobar";
> > 
> > > If you means put on top allOf, other platform use clock name such as
> > > 'dmamux0'.
> > 
> > What? It's under an if/then schema.
> > 
> > Rob

