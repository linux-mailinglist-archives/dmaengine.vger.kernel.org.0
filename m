Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AD72EECA
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 00:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFMWBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 18:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWBr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 18:01:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A185186;
        Tue, 13 Jun 2023 15:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1/3Yie/cevBOF/eEkFOwuoe8fjsu278R3c8TH5QwiHK/GG10EJoEMEFVxMih1mL+okKIvizF5zgkMzmcVkkUBsnq/C9rMOejaU90d7gxcuv0dc/Gp7hhxisvFOfdyBAt4T3BVEOEIdywdHKrFQSsRHV8kogcj3oAfQEH3zUK49cRzTiBr/77gKPpACrfdwX9mFw3TZRptckLmNJ9dSs8kx/OlArlNW7iWmQfsx8e9Ua0Ej+RhFSkaj2Msnj8firxqkWuElIOfFIuaGWkNUqW25ts3R3lSsgaS4WGlpICVdVwq+din3tSSv5noRgKoR9tVBkulj0RIMfmtmVSKU+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NPj8518QcUsbQOVef8+ATPB5cCzTvnb7rvOP3V8y78=;
 b=N1ig9bLNiBFAYAycDN+xEnZH365BIeqaLPI4Z9g416n4exLZy1h+1d6PJhUfGelpGx9nVitjDQxObJj5f+duKSimuLm8sjgbX8oCgUk9vXPIFHAei5DrAgfwL7G1eDoV3c46gm0R/fEeRAQQOfmRyf19wOmUYJccuvIDJcZOBaV9aRtPCXA05TfmTNosKv5TBYUiYlte2DFd/7YuIc9qZrjl1z8SmjwJEAu6AevT5GGt/isZB/MJqFZ+X8p/K0sQv+PlTIgenUNLT3J1k1ai+CHRJLUqml5pMfzJIyq30gnYkY4pJLoisl8c/tHsqX/4qVgNhiiqqoVWKI5DMT9AtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NPj8518QcUsbQOVef8+ATPB5cCzTvnb7rvOP3V8y78=;
 b=gt0PiG8FUKxxcyAWqSfqYnQyCLwveemol6mlGDzvl4BT/XTlr+L9nMAFIGzt48SbHQ7hWC9O9VgYxjpyzhaoD2aV2I+hQ8eJezF90CwQtEuLoP3cETcSsCJuKcJ95+fzcpIXiAkb4z/DOGUXXRWXSqT0NiLMuBhSqsPMjcG3Vzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 22:01:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 22:01:40 +0000
Date:   Tue, 13 Jun 2023 18:01:27 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: Re: [PATCH v5 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Message-ID: <ZIjnNzemHm17MNzV@lizhi-Precision-Tower-5810>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
 <20230613213149.2076358-13-Frank.Li@nxp.com>
 <b3a25a5a-d39a-81bd-0593-7a4b76aeb9bf@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a25a5a-d39a-81bd-0593-7a4b76aeb9bf@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 98139094-5a89-4113-2263-08db6c59c435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kD8Q1gGS394E9kW8Rdzq/Ph7hZ/Z5jzt8u72a8QFMb527uFpGb7xT2o4cSjIQWIGauPbsmwJB69PsCqqZvPPZaXQ6I1hjodab6iFln1z14tUVZ692eKYj2U+ipYN+YF8t5BpHykYU6J3IKQQVAAuo6b7ZDux6LUTp3LA/yCLz2+Y0tT/b9a+D1FtLtSfnP37nyq1OAhVIxABp/R4k4JYsfArk8tk6+xPK8w2WQmyzgMhuMnr5U5JcBs2xM8bN8Vu4GT165EOguqtZRrrLBj0DRJ/ENdUtWyUI8vN5xr+LoVKyzwAOAMZCCt3lxHZRm7CB1TyfGB9mHvUAM7iiU32ZsHmco4NpkF4dsG8fOd921oCWnGwz+rnhLD5MZMGsbv1gPLRL3GwW3xaK7fNd702jz8eaick2agR5yuKXUhNts0pUzEKShVQQswKSaXz9YDoGcpukeao0jVPrdI78VcJ+wPGao8vmap6gmymERzhkNKILie45bN/1504fCQuUVn8IpXB0SxC6+r/q7piqRkpZNv4lmFgIqTCud6zVDSnq4OR/cdMmMncmfJGXf0+urjBjYch9qgnIj7BIakqOV1BhrB+aO7coKmyCxH+3Nmi8jeIwoUQAwIHHoRemCaWKkYr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(5660300002)(4326008)(6916009)(316002)(8676002)(66946007)(8936002)(41300700001)(66556008)(186003)(2906002)(478600001)(66476007)(6666004)(52116002)(6486002)(26005)(6512007)(53546011)(6506007)(33716001)(83380400001)(9686003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCBws9xKRm2R4pN3K8Fb/8IGrQouwGH2tKXrlW2GiZ7oMDpt1PLB4/WB0/8j?=
 =?us-ascii?Q?j9mlaszPVtxE9CJvQz3hq2WHnrJXZV0fwfSrfkLaZ8vKiR8Jn8yR8FR4W1n5?=
 =?us-ascii?Q?IouumtyB41xReZVXwOqLkE+7lAc5ZPsspKRTuxBaVAcUL5v1L90l0xobVMmh?=
 =?us-ascii?Q?0teIPfT/pHS4NCHuAgXDH6LMaL1v+iuXP5DRfXGkXxNAm4xuQw1aQg8zuLOx?=
 =?us-ascii?Q?DLs/3iUHbXVvafZ2sobj8EWamR/leF/eAb3H2OFCU8mKczIWp+nrmCpX+lcW?=
 =?us-ascii?Q?upfjnSvmIaE/XTwmL2iNc/2K8DbefzzhtUJUa5Hgr5s3lnjD4WZN9T2+ieZS?=
 =?us-ascii?Q?oCqEIZCB9MDcXnFHACqo/OyzYbnjI4BqI49lak6jUWwXKZlRYtnGKt3xlbb8?=
 =?us-ascii?Q?t6F26SyKRF7ddhHzWDZD5jyxsWXtPuM+dBpB0H3XQzQrCNTQwihCY+qXBZbR?=
 =?us-ascii?Q?Z5mQUBc3MLL/eGekR6fLVmQm+GwUX1jPt4DfZQpu/jf+eouBtlfxolKCt7j+?=
 =?us-ascii?Q?WJQnzrhmUk+0xEIpbbLRXwGV1VchyvhNbkeeC77CGNqFOI0GB031NoNlTdsj?=
 =?us-ascii?Q?ee8VKtkC3rV3uCav2R3UJaFEhevokVGMcic0+7JRPbbvhXRnvp9pytGNHuLg?=
 =?us-ascii?Q?lskYIsx/A2XNol/WgIZ4OxPAtnQOwnvNH1Hpj2jjASM6kDpxUSIJFKNq/mRb?=
 =?us-ascii?Q?RcWRNFXA7TNqHsgoPj3sIMRd0Cgc8iAY4RkxHHFrmrMMYyOiwb4e+uw2HxXd?=
 =?us-ascii?Q?PndqCSV0JGhQq3ZGOh1sP2hJaVYpmnE23W5CslIPhKwLxHm/And/tGFhcbw8?=
 =?us-ascii?Q?GMQlOxik6umGNIBsC4jweQRYxobsDiQrkBOCuTMjgHuCO6d9kU4Ql25yr4U6?=
 =?us-ascii?Q?ki1vK6s9zBdCds59ylVg+5SPpGGpYjqOuIzWv/AdAhhQfCLEc4in5CaqZvDu?=
 =?us-ascii?Q?+VB7BEM7aiF0SXHzLcvRw/2Q2BDYPtmuyOSp/W2yfTjNiSt/GLzlR7T42fSQ?=
 =?us-ascii?Q?0+Ot8QNWY2bcx839S5wknVcZH7/WBdT2+8oc8FHXcxSWEE1e7Pu6rOxDBo8j?=
 =?us-ascii?Q?ZGNOVpOZNliQgmxOggTaBBcYnyCakOAC1JMcjFshTlZlEhzawwPjXyjtpHp2?=
 =?us-ascii?Q?rPxUgHm2UvaGuKbAFFG7UimTYCO/rKe6ghI5x7IeJxCWpqsZTh15YfolHcVW?=
 =?us-ascii?Q?gHuAHKaUIkJfnLVwYMNa60j5Bx1/67sXU9PFujx2kK93Uq9E95b0o9sWEV9Y?=
 =?us-ascii?Q?UvwwE8WEtkgmPGmqAyFnJyV2gzHbUudSwW4pQIHbYKGQSL0BPsWiDLW51l9x?=
 =?us-ascii?Q?lD+AfzroK0kdT1O4BFxy2FMEOwYL6mWhFFpDX1rSILUNSwrFKjnkGFmjXBzL?=
 =?us-ascii?Q?jTKm3n+7XNE7Xv37D26JFykYaA1Ndr71pSX6g/llqiLAE8VOAtzz1SUNkKSA?=
 =?us-ascii?Q?BZqSz54cb3uPpYeTHM5pD2JY0oR1sGN9YizvxSH1aAm8ncZQDJo/bBYdR8Sd?=
 =?us-ascii?Q?/WhpVjEuEQZOP4QUzKcmyVy3hstf0ATG0jjaIfZgF5yZlmt867Dc5Vn/DURG?=
 =?us-ascii?Q?tZNLGRHyCykxbtnBJzM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98139094-5a89-4113-2263-08db6c59c435
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:01:40.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJvS9bqgcOC9lqrTDapUQltmqSxXrEuaop2pbtwW7Lrx/o5z74lYqAT3WDE+2UJFMTw+KMtcDUq21/Tc0Z23PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 13, 2023 at 11:43:31PM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2023 23:31, Frank Li wrote:
> > Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> > i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/dma/fsl,edma.yaml     | 118 +++++++++++++++---
> >  1 file changed, 100 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index 5fd8fc604261..2f79492fb332 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -21,32 +21,20 @@ properties:
> >        - enum:
> >            - fsl,vf610-edma
> >            - fsl,imx7ulp-edma
> > +          - fsl,imx8qm-adma
> > +          - fsl,imx8qm-edma
> > +          - fsl,imx93-edma3
> > +          - fsl,imx93-edma4
> >        - items:
> >            - const: fsl,ls1028a-edma
> >            - const: fsl,vf610-edma
> >  
> > -  reg:
> > -    minItems: 2
> > -    maxItems: 3
> > -
> > -  interrupts:
> > -    minItems: 2
> > -    maxItems: 17
> 
> What is happening here?

I found dt_check always check this part firstly, then check allOf.

> 
> > -
> > -  interrupt-names:
> > -    minItems: 2
> > -    maxItems: 17
> > -
> > -  "#dma-cells":
> > -    const: 2
> > -
> > -  dma-channels:
> > -    const: 32
> 
> No, why all these are being removed?

I move common part ahead of if-then-else branch to read early.

> 
> > -
> >    clocks:
> > +    minItems: 1
> >      maxItems: 2
> >  
> >    clock-names:
> > +    minItems: 1
> >      maxItems: 2
> >  
> >    big-endian:
> > @@ -55,6 +43,43 @@ properties:
> >        eDMA are implemented in big endian mode, otherwise in little mode.
> >      type: boolean
> >  
> > +if:
> 
> This should not be outside of your allOf. This patch looks entirely
> different than your v4 and I don't really understand why.
> 

allOf looks like addtional constraints addition to previous define.
for example: 
    if previous interrupts is 17, I can't overwrite to bigger value 64
in this sesson. 

previous version: dts check report two error, 
first: interrupt is too long. (look like check top one)
then: interrupt is too short. (look like check allOf part)

> 
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - fsl,imx8qm-adma
> > +          - fsl,imx8qm-edma
> > +          - fsl,imx93-edma3
> > +          - fsl,imx93-edma4
> > +then:
> > +  properties:
> > +    reg:
> > +      maxItems: 1
> > +    interrupts:
> > +      minItems: 1
> > +      maxItems: 64
> 
> What's more, you don't have these properties defined in top-level.
> Sorry, they should not be moved. I did not ask for this.

It is there. 
if-then-else before "required"

> 
> Best regards,
> Krzysztof
> 
