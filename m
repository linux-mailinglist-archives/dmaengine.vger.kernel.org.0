Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546697865BC
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 05:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjHXDNu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbjHXDNt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 23:13:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBED10E4;
        Wed, 23 Aug 2023 20:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWc65kZlPRCaKZTkW8LU/7Rz617JF8G8fW2fCH7Dozvtj7/lcHp2WaEaK0r3wBEGDr8Pk0D90n6kUa1PFultz+fy2f0d5T1716IZNQGo7xIgR6jrkYaKVGTZzOaHOpVFIDMcZJGrjuVaMycw50kNgQ7MSjgGMSfjGdlsW5BL8sFCPbfYfIT4IlCFffT+25cWLjfZppH6whP/WvBtm7SeoN1nPLxpIo6qSfffikWQLnZySmjP/iZ9jycAVLHkJgLmn992k7zfX3DIe7od/cuqYtgs3D+Ey++JBRgZlcxbLHQ9noVMs1laJWv4b08jHJjJRhRuy5shZQBZzbUIE2e94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVPLDlvcUppGsQ6pnpSEOZFX195cKKj0cx5qYMrmLfU=;
 b=J1/ekvRkwKX+HMDebXomXjLaEdg2aWNyhWZXSN698eYB9PU9+iC+z1OLk+7pEG4xq/MK+cPED7JwGgalpDcuUgSRgdVRP+EkHDKT1InA42defkv1ncXJ4UjxAcGPqJZQnu84gejILvT3p2Cy0obLAInSh8w/KwPBOA3VhbVelzx4rUdJFYxmh1S33KGhIdelb78b7lh4tNmQDgJHWI8qtZUDfV7AB4rVMhwrYe/HHQ83yAf7QZhl3M+OnUEIPwlSuCiO74gAv0VMD9f6tNv3piOniDmomytijUN6uucWV+2/q9chAoLlQoKY4e9Wfyzs8m/XUPGLWQVL5ozXmsUUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVPLDlvcUppGsQ6pnpSEOZFX195cKKj0cx5qYMrmLfU=;
 b=efC770Ck6BOWojfI/TuFDoJoCrYQg8sINMQwCwXh2ZhmSCuBLqddc1SXsXGJ5yXvUlc8Fwxuo7OcP1u9Jq1oz1zwK3V8pWh7QPr53kIyDQcf1N96znCkJM85El3lQpKciCRGLkZCfuFum7w/26OxblmHbPaWuH0aXQsjSjg3YtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 03:13:43 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58%5]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 03:13:43 +0000
Date:   Wed, 23 Aug 2023 23:13:23 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: Remove unnecessary print function
 dev_err()
Message-ID: <ZObK02bAF5ABy9b6@lizhi-Precision-Tower-5810>
References: <20230824023417.120236-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824023417.120236-1-jiapeng.chong@linux.alibaba.com>
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: e70f270c-a614-41cc-82b4-08dba4501f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tn5o3hgYpZ5/LoMaBR26qGadY6Oo1em+97+RUADiezt1zyCIqG5uZXacpGD1HXJSgMl74+YUXisuSscZ9w4U1d8FA48sAvVcGNzeoj65/3ugKUZiZCABuwnAF9rlsL3hkM1eC5WR5yB+sTtglrv3RNqMUivQir6uZ38HtBrgSPK5d1IGGCCxdo6JGimpd5ZfV7v2vJ03eAF9tucqFmXUy3XLK3ytrljPoVo9zIbCBosNO5mazunFAu0mdsC8VYMVNliMXi0rpY11Ol0Znu/IX/+xyB1X2c8c3VujzRqPd/z7sTeL5lqbJ4Jqyf6SBo+ixlHzqFNPCJYaL5hh2uxky0F9pyjM/LY50aAfQioIxCyV4F/FDBt2ckXzMa9VaG3PX7B2NS5CfNkP9jNsrGpolV0j25VvdHym9eXo9jCLVsOz2chqe2Sem0l/iSFlfWJe9Kcz4gJAaeirWit2CZYW6Jic060zilCb61Z+Xfyz/pdQUwckEcy9ts8PbG3oxCgHXkXu3z8n/Zn35Qp+CdNMix4KsBZoVt7RveQDuOYuKN/c2CNmhpBeqbNN70q15sSgHNhCVC0jgPc5nZKJlqFgNfizgbobFTQMpYy4mPc8iU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(5660300002)(4326008)(8676002)(8936002)(83380400001)(26005)(38350700002)(6666004)(38100700002)(66946007)(66556008)(66476007)(33716001)(316002)(6916009)(478600001)(966005)(41300700001)(6512007)(9686003)(2906002)(6506007)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fha6vG5qrBzuElOEyDP65RE43ki+ttCFm/k7L6VCJPqkidQLmh6OAWhmVjn3?=
 =?us-ascii?Q?5zHr2HfPZTiF9Ll6mIfL/Pu4RtKtD9ZDRbnjqUdMOclRJbjnxqv/3B/pdJJm?=
 =?us-ascii?Q?HfEygbf3Vfc57EyoCZMNbwtO5zHVfaeorlzbLIfEOvC7b02kbbEmXqQfvTap?=
 =?us-ascii?Q?/kLmXxnnqzDDgwkygypzZsCejTAruYW4cHYk12HCK5+b5AgRcj1DtwT7z7UK?=
 =?us-ascii?Q?aZCoSwAsmQAG0PLMehIzjTvpU2tu3aAtrZwKycv1182kVFlKWgFTS8RujrbQ?=
 =?us-ascii?Q?vLIQ0EHNJfDnT7H5lzUe9epoCJefHnwScLI/MtJ3HvqPbtAwJx2RVH+Uerll?=
 =?us-ascii?Q?JP4eWW5G/Ju40DPgZkCN4gKrfKgmjImd/YgrtaQc/wGdJx6lfiZsc3JryX3q?=
 =?us-ascii?Q?3uVOqHk+w/cREkKXRBfiXyc2AA1SObcIspdS2gmOfQovtmp+zeo6gHRYbesL?=
 =?us-ascii?Q?tsqGOw6FQ629VDJ9nKEJDAzL3t51CARniHOznQP3dFImBKnsmDr378VMJRz9?=
 =?us-ascii?Q?EC0KYKb5AfkGiGHXtnIeC2bkjfMehXD8Ub2rjxxIoWOSW1TwaxwrfvRN5I+z?=
 =?us-ascii?Q?r8/dZPTe2SjhpUE2qtpU8fx5mdiXpNUldfSXTZjjL8t6iONN6WR0EbOJ+mib?=
 =?us-ascii?Q?EWjN3OK37291QG8hMFRtNWCe6jmJZF74ZLuentHqFFTaa5dYfiZ558nn4h17?=
 =?us-ascii?Q?yzJJvKwO6NKJUxiAOgl9+QN31r/K4+nxK8T414bPS7tekHlYm1l6jUIzClCc?=
 =?us-ascii?Q?9jWw91z9wwLQXe5jTVRdgrmpU0xPpI3qYoEX8KqUJ2coCZkwDJ4eiw2Af9VS?=
 =?us-ascii?Q?faB6WjAdePpqlGgTYJISj8u1DjQa3YT4k+r7dnpcYcNqftrQiCetJlMCbIcs?=
 =?us-ascii?Q?pEGJ1BgXk2MNocPWslup7hZguYH0o9HrMGrxsB2JT5+nYZxLtZZFsucr8YzK?=
 =?us-ascii?Q?hk/Ty9GHOoy4vVSTHheSWsB7J3mrGsXbsJKsWMcQ7qDpxbx7ML9eVfQrLbRg?=
 =?us-ascii?Q?r+SZccSAM5TrW0qcy8gmR4MDfrcw+THu4KuLF7tEXE+Ef29ej5SgSA6D7fng?=
 =?us-ascii?Q?03Ie5zYe20YU2Iz/wRbRt0wuG82B6LkcGHFE6QwzAMtqALqULvoFf0pE9sXr?=
 =?us-ascii?Q?aXN928cBj85A4XEad2x1CKYC91ErIPkb6ErkGwtnNBvtORpMHOa0UStavvo7?=
 =?us-ascii?Q?lCZURmG/jIUjP1xJ//i+jAyLcgm4dcf64eDnAar3F3Nyy7+J64Jhr3UGAA7r?=
 =?us-ascii?Q?krbDqDHVEj0nStJzCWzz66WtqPHr1ki76JrU4QcKUFph9RDCiuryWr71BZuC?=
 =?us-ascii?Q?SXrRbAHjbgWAK+1pgf4vXnMJN/0fWgBL3sDcB6tzqRymYThJTwEW3/5D1RfV?=
 =?us-ascii?Q?PQvs650tnyZ+3QKG98DHJM+iLhAJgWMiXXHq2y7khYNqd2uxFqKo3zKXpuT6?=
 =?us-ascii?Q?9TKyhmQjfAC0saCi2bw3gTSAsDGz3xRC/Gim6WsBkbm7XQt5SIlBh1zr9Oeo?=
 =?us-ascii?Q?T42SumgGAzAZAqEUsJENAr6jNzk8bISvi4tnApIfHaoQBQke46PSIgnLfqIO?=
 =?us-ascii?Q?FPdhG8gWkAqRgU6MiPnKVZqIb21mUIxWMQ8sElin?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70f270c-a614-41cc-82b4-08dba4501f17
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 03:13:43.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7936kJqSaJf1W7sTmnlrfdLNSXHngezg5yhdDh1MUacKHeClqV5NHUXch9sCh1SkbG3i70uSyK+5qVqAnCOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 24, 2023 at 10:34:17AM +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> ./drivers/dma/fsl-edma-main.c:234:3-10: line 234 is redundant because platform_get_irq() already prints an error.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6208
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 63d48d046f04..d493dddd55b1 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -230,10 +230,8 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>  
>  		/* request channel irq */
>  		fsl_chan->txirq = platform_get_irq(pdev, i);
> -		if (fsl_chan->txirq < 0) {
> -			dev_err(&pdev->dev, "Can't get chan %d's irq.\n", i);
> +		if (fsl_chan->txirq < 0)
>  			return  -EINVAL;
> -		}
>  
>  		ret = devm_request_irq(&pdev->dev, fsl_chan->txirq,
>  			fsl_edma3_tx_handler, IRQF_SHARED,
> -- 
> 2.20.1.7.g153144c
> 
