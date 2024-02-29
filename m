Return-Path: <dmaengine+bounces-1197-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11886CEB5
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC8E1C20DC8
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04503142911;
	Thu, 29 Feb 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1W16ORT"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A471428F6;
	Thu, 29 Feb 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222641; cv=fail; b=HXb2GBZQsXmNRoc1wJ+nhjhLy020g4d9mLP/Vo7gP+ywZ+h/MaG1cAFhPiX/N+dJ7hDF4RbEngZkkOxbOytpj64KurO48Oqvoyf2bRbo2Mm68oEfxJbqEjTofa3v8dsKIp0KxFBK/+/hiM8YpUAfQ9P2xdBPZX/KpIg6L9vInOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222641; c=relaxed/simple;
	bh=J34PPTPZgDMqAJFs3GBmF2I1prgWnq03Z89gr/voEps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eFPd0RPIFOa3KKToQH2CdJk6ozD6CfWL0JUlBRNmasvFnnMuEGG74BTEEuyvbDM1mvpSqVxJw8HDTRJHlgb3xCQR68VbwNn5vzNrE76cgN7JllpBAmUN8hDPXLh007ScQUZXL1i2kYongkVkdnjLGuhUCnq8Tm0w2hSA+HJqelY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n1W16ORT; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsB1VpTf9q2ZZRj+8d6naV88OJb2oriN4MSDcoqSvhFllaT7yfjataVDG7xbXBDfKp+mbdZznVtFQ9G32+OMeNNkvAmfvxPU5NcOdjpquU5VtRF+vNeWnYjvG6K3foKrGAJq4LGw7NbSyg5c/l0YktsFtFX8cMk5gVThzQPQyD2p7ADyUHmPo/kM2w+/fwRSw3qdyoY22kBH3eBZyX5Jy5FlOvc3Otsj0Xzc+KDH9Mjd6vnZDfeU+IFD1Fm7pJV2nYsO19E6/n9nolldkdkYszmmJSCH9vC/qXNJ3qfdZ2x+EWPmS9VgpgU/kNjkWuhuV16l6Uz/FATW9CUC4XYEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcBMaqnfcJaU3c109p+MopciobkS2+LH7jcK3QTrXEM=;
 b=SjSu45uke1va1vVflCB0U4VT7gTiA0D0ZObIZ2z3pr78ptUXdPGN37mjpxILz2K7Y/6eKDGNSbxN2lEefL1Zmm/108inI/oSJyHlhI1S+YLlHpFw1MCX6JCmOg0rF+b++k1NmYFBRVKX15A1kvETd9YWuIMLPicS9sCPftgWzR7hszg8ByB0k3+OTQgmbB5MggHIlKoXw2E6zIJUf1ThSi2b59fReL3YEeENvHJG9BfZnMMO9AQLLU/AcNakYf9is4H49GIzhD/+fq5hAmbddZe8vKWQ3Bk+J+fVo+7QzCGRc71OkBZwjFbeExoY1gOMUg2NXyolE8xTsvLOU1aD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcBMaqnfcJaU3c109p+MopciobkS2+LH7jcK3QTrXEM=;
 b=n1W16ORTj+eUe6B8zHHVOOVc20DNdoxoebNQ6Ufs+Qw1S9vO/iYaWJvhBjQXP4wazfSNaSluXkgUYfSjpvnO9ZUAICmDWYTCRadnFyWRB9PXCxC00OUlNg5nfuFbcpzPByL+QcMQpC+LlITV2IGfmIyJ+PoIeN7pWvs14pp9E5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 16:03:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 16:03:57 +0000
Date: Thu, 29 Feb 2024 11:03:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <ZeCq5Sk+sPA9rEtI@lizhi-Precision-Tower-5810>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
 <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
 <bb3b61b6-4f39-4123-be50-0e2c8f07eb99@linaro.org>
 <ZeCooFQtOK9MuuJn@lizhi-Precision-Tower-5810>
 <ec835855-49f6-4b9a-9c58-e3fb90946c26@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec835855-49f6-4b9a-9c58-e3fb90946c26@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: b466f03a-a194-46d3-a01b-08dc39400906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9y/MKehX7nFJ+ySl/9nISwxyqJ9wy5cxQnLPAvW0MtUyT6BTBJf9G4o2zoQz5k00hdju1zNpQ+jsgFbuEFhqHLdihVcltpMQ33RCX3dqjVpjgji9Qjr7kUtaivKqosnUpJKWI4nZ3BtMaDr8iNtWQ5+YYNYGnoIvAkOTVj+Zk2qyx3fS50hKo57TBGnLTj/p017GpKWnzLi1W3Jd2O2XkZsa8QWwBiGsBDdmxxYvhDYpWlLTgjghxAkLt7SxQEUZm4dzqXntBzD56xlRXieMSS3M56tiV4JTv99x6XvMQLE76JbL2hLyHYcbTf2nDD9dpVQO/e1oekIA5Zmcux5VUB+07Qo7nPKtkSpJjHz3ehEv4YZB+rvz30O0VCgPiekIUofCpJQjHm5YEeQoPl4TODW/16etEVJ6NG99pfhhyNMD1Yfq6PbGxeGeNtgJbtCt9KgspZ113UeZZcUZgNTtg1N3ueiW/2mVLfGx3nxiWnZBs3fMXfl0oPXQlfws2FyzLMxPenM7JaJ8/YVqDdZhtTnq3cQwCxYkwrKR+s3rje12UYeiLzJFG/L/urTjfQwclT8Syhr7trIZp87nFK3+xTsZtLX8xsZtZrYHe0AhkL5DGQYb4p7Rz83eJSyUwTBB+29o+p9BFrfZ9gPNOHNNzn8pFrK9wdFGUj5c0O84gJ6xp6hN2sfS4PKxgto9lJT6gQvwJ/Tmfri/kEl4KhB4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjcCy+mjIrDzqFzxHD0ERFqfa9FcsKI7nIPTx11guxHaFtYvbN1uytSjPp7r?=
 =?us-ascii?Q?JF3+CNxEo/lBUgoIGkxVb0uVUuLq4qfDvicBTPY+/rgHZtyg3THJQfW60ihX?=
 =?us-ascii?Q?nBCJw+pgTXdtoSXzh5yju/78cKrUkytc7YoKTpXYCD7WeHBMAnPZrx8nbh8h?=
 =?us-ascii?Q?NaBkdc+1ZSpbEeSEUpqXcM61U2jZfAbWjmcU0uwAchcBLe9m0mNFG6W1Gay8?=
 =?us-ascii?Q?84mJ3v2sOjOo+MwPPqaF5wpFTo5HJPEMOQIOKC+t7QXJ3L1V6OH5F/UkJfzS?=
 =?us-ascii?Q?YLqjvwo7NfZYxEf8hGZNvm353iKurJeaxJygxqTQBekrPVVHK7hLOFSufrWn?=
 =?us-ascii?Q?eoFnTBUcL1W5cSr/lPB1XmjRQV2ENDsKOP1A5IhbwrdfcYIJE3V7xYvZ2ZnG?=
 =?us-ascii?Q?0tZqPAP+LbTFbplLv2AZi491VgwOtAF4mGRIXb/pb5ddQvrJhzdl6MEMrE49?=
 =?us-ascii?Q?DLCjNPfh9+HNkxA40Nqk+p0/cJaV7yLWtkjx1kYXsZnvHcDeKm2i1BNXgaYv?=
 =?us-ascii?Q?ShU61wiEs+wsSErmwIR/EasqCZ+BVZG1P9plmnpmTFcjrvosbl58uA55t+e6?=
 =?us-ascii?Q?AZ6/0IcOelAk09JekXmye+i0MPtVTy5WUbNxrl7+ukQLSkwji4lFOX1kiFla?=
 =?us-ascii?Q?0uX7Cfcz9lZPcRRjHYETxuLkpag3CepIqBeyW0pVN4QVINQBy3al3VsSLJNV?=
 =?us-ascii?Q?E6lTCJBLZNvXwpyzgcL3A1ByHC0KHCi1Cuq9KJuCo+xFLGyhuSGzAr1LTFGq?=
 =?us-ascii?Q?Ub/7mjn/cDP/Se2iR9t3wXygdksYuoG6B/fQp7AAI3em79ITy+3MA8X+aQtm?=
 =?us-ascii?Q?62xmCaFzVdL/fNOJNmpfWLPBPnU7lu7LJ+sd3j0OFeTh2YBbOnSNknZeMxYW?=
 =?us-ascii?Q?aqa0GiAMtc6lHZQpI1H39Q39RDpQIxC3DSdL0xE/Iyeg7DMLoAypwq66f8dH?=
 =?us-ascii?Q?Po8h4DcN8UjCRnZuWQHf4Y83QbZacm7v0Ci++wyl69u1W+Au6g0K2ZIWI3IC?=
 =?us-ascii?Q?eKfyBf1og2EEs+04pFubdVdcoqXAS2lNBlvURfKwgBqBD+c1DyqqqGVrolQt?=
 =?us-ascii?Q?D9AMJHqOfsgzvA6sv1Bie90lN00Ii0WqvJHGaJOJ1PMmKYgL7HFdMpoYHM7A?=
 =?us-ascii?Q?3F+ZU5Xxog1vA6cpv5lEq7wjRXxv9OwfPPJdNYg2p5McnnuNxH+hW4OQRl4Z?=
 =?us-ascii?Q?mAHxh2P4h6tyEGqJEpfQP7V2fQ0hyk2DcUTygttffUhM3twhEm79SRW2THLm?=
 =?us-ascii?Q?XAMoBz9pQPoMyUaVKY2fztDXd7kK7jaVIGZf3a7gOs3/6F58MQRlO2zCPuMk?=
 =?us-ascii?Q?pQQ70y1Jsu+u0/yzyv2QVrheL2OLBYLvhLSuSrCyoHVG/eV/onNFSKw5oo7l?=
 =?us-ascii?Q?kY5JMyTbSmhlxN8LihmNFN+0VVchhSDQbGLA2nfnk4M34tPzYrecsxo54vA6?=
 =?us-ascii?Q?4IoijdEJwHRbFEXGp35DGpR+ZvJB300TgDbEMW5nrm9AeBuKgE5ddHjch3KE?=
 =?us-ascii?Q?VhzE8vB7VFjImdDygxW3Une5EErEUXY3UuWQw7XnVYkfCR7nIeIowKM4cCjc?=
 =?us-ascii?Q?uu2kgjM0TdwfVlJKT9jghA9HC8s1RPv//DPcjJep?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b466f03a-a194-46d3-a01b-08dc39400906
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:03:57.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx4pFx9R/AkC10Hvnjo4HoMO5PY1V0zGfnMvw/AVQUVW9+DJoUOi1gqQdANAXxlkHXHx1RXelq4L7b5+5ZQqaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

On Thu, Feb 29, 2024 at 04:58:23PM +0100, Krzysztof Kozlowski wrote:
> On 29/02/2024 16:54, Frank Li wrote:
> > On Thu, Feb 29, 2024 at 10:49:43AM +0100, Krzysztof Kozlowski wrote:
> >> On 27/02/2024 18:21, Frank Li wrote:
> >>>  
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: fsl,imx8ulp-edma
> >>> +    then:
> >>> +      properties:
> >>> +        clock:
> >>> +          maxItems: 33
> >>> +        clock-names:
> >>> +          items:
> >>> +            - const: dma
> >>> +            - pattern: "^CH[0-31]-clk$"
> >>> +        interrupt-names: false
> >>> +        interrupts:
> >>> +          maxItems: 32
> >>> +        "#dma-cells":
> >>> +          const: 3
> >>
> >> Why suddenly fsl,vf610-edma can have from 2 to 33 clocks? Constrain
> >> properly the variants.
> > 
> > Suppose you talk about 'fsl,imx8ulp-edma' instead 'fsl,vf610-edma'.
> > 
> > imx8ulp each channel have one clk, there are 32 channel. 1 channel for core
> > controller. So max became 32.
> > 
> > I can add above information in commit message.
> 
> No, I meant Vybrid. Quick look at this code and the actual file suggest
> that you allow vybrid with 30-whatever clocks. Test it.

Any tools or good method to find it? 

Frank

> 
> Best regards,
> Krzysztof
> 

