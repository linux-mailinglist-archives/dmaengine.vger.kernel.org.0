Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36C39D75D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFGIal (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 04:30:41 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:17124
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230215AbhFGIa0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 04:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvXhVLqmWtrOHPxvXTqDRtvkj56BAVQLqGcSb/bB4oSF+wpzER1MkWifqXpjnW9K59wpnHU0Mlhk11HjoTUtmA1BBDMtHF6ntrAFA7pulLP49ut1r9W2G/hEKozoUDjKXcHH65HOICYWdmcbahZxp7aC9i5GZ9vcq7sYzE5SWI9UsMtRiPkvZA4uCTg/grF0bFHmgsoZNYvG7gp8ybgc+cHj4db/OZipP2d9bPL9qXocXXrnNi5BGcl1gmiKAonRG6ekKtBgeSNj3EybeXv8TygHfVN41ppc/R/YCdCqwwmfCcI7604Z4vHyZ+ZZVWXH1BuH4dXrA5ZcUc1ZYv0Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjRYYnXmBCJZfHBxJ/BYk/dglO61JCCnsksjTQjb+0=;
 b=Xe7RsFUB4igm1y0K4AZeMOFiU51BWgQAl0qkElqv9Wwm4//yTYMyKwDxKeG1lhWH0SgdskEf0wnGTfKwK5pD4rOz8BwohgJdL4Ie5ZwJOGNWU+bFiiP6j6sVKZHbKOSGe2h/4ij1GZGGAA5Dv7PanS6q2ky/tkgxdlA6ALTdukhyUO2xJw4bkET4BXdMAbup20m/s71NkGBHxxxKQXBhxYnkgd+mMnbg2n3gUoV7SO/+zoNJXvNRgss34V5x4Ct52LqSlRG7Pst19OnUagKNY0bJUpe4+ySVRw3ZZO7D+0Z/029MGa82fhmLmyWrSOgGXWC3+uq4QyGp9Jha6ZAeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjRYYnXmBCJZfHBxJ/BYk/dglO61JCCnsksjTQjb+0=;
 b=GoXz0V09NdbwpopJNYExyDmRcZYQusxLKaWRpJezHDuz0W1Gyy6XuTtcpCHBHGBvv9n2U1wWYQITPPJr9D6OONweDAZmWEDYfN/Qp3RSX4TmOPJcXVMXpBKok3t92+jgCgpUkcjmwfN9xsakqKEqmrgRciJNkJFQJqGcQn9jXyw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7438.eurprd06.prod.outlook.com (2603:10a6:102:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 08:28:32 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:28:32 +0000
Date:   Mon, 7 Jun 2021 10:28:14 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dmaengine: altera-msgdma: add OF support
Message-ID: <YL3Ynm9xBQ419qK3@orolia.com>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
 <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
 <YL3DvQWhn+SsBqhJ@vkoul-mobl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3DvQWhn+SsBqhJ@vkoul-mobl>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: LO2P265CA0387.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::15) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by LO2P265CA0387.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 08:28:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea5c62a-dccf-4766-0169-08d9298e3c46
X-MS-TrafficTypeDiagnostic: PAXPR06MB7438:
X-Microsoft-Antispam-PRVS: <PAXPR06MB74389854DB5389E93CC55CCC8F389@PAXPR06MB7438.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TpHUOnnrEOJaVIAuIgakzHj8ebRoSsMJ/tJktBniXG2QZvHPqjVpAeiNcmcpUtH6Xs5d9Gbjz3HupUmEPEEwPTNsABY3mvCbhkwVGs4JIv9HdgSVLpQFp47ym/rqQ8gRyAEliC2jic36PShmxMA+cFSS82v5K+mDPY6OlL2YhX4qxjgjGiEH/SJz1WRLTbWtGBVUkF/jN2C1QWeforvJcb6eswSbzHmQnrut6VN/PeMRkycJ3DyobyOuO279r5uRROJ4wH2SJn/Zc7WjzvVcHGSnXuJihDNy+aLc8OiCYPb/nFUM+6GcMcdpMvLMwQMEMJiRT/B2HCcvISmBMDiGRF+vbpcyofaU5a72Y0HbWr6rKziT01L4Rhg/Z0fKHJ8lRpjj5h4myxRmfmeLLGmialSOVAy3dqRRoLmsUCp9UKggD8obW8zVyaeoHnGHXjBiPIE3WPzUDyCIkbPD2axcDr2I/GAMaghMyTutDcu3E87AtcsLhd7sYwBiIdselfsGwGHEvq/92ouI9W+dY4ssA1Du8r84NUkZ1KRzmnMBlMUoJ2vDm5cWl8eRUXQdLcSujT2Cf+I0AQUuBZdcxfUPqQhJh3eTh79FOv5UoG3v7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(346002)(366004)(376002)(66476007)(66556008)(66946007)(8676002)(6916009)(54906003)(5660300002)(53546011)(44832011)(16526019)(83380400001)(8936002)(186003)(2616005)(55016002)(36756003)(8886007)(316002)(4326008)(478600001)(6666004)(2906002)(7696005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YCsPeY/eBB8DtYty1hjsa74suOlsIKJUqBSiO+NgJQdkT3cnczfdGGLKL8oL?=
 =?us-ascii?Q?oyIuLaMmsbx1ZuAEdzbVSPzFgEn0TnxipZ4Vm+GFT8W9GntV10i+jtk7rDxF?=
 =?us-ascii?Q?4Dqlcpa9vqsKRXPmM6r5lAObh+OkB6ras+fiDRM/6+2f1yJeFKqpkJTb2SFz?=
 =?us-ascii?Q?H+5DN3V6N06AIB2PWbuI7rQhNZ38UuUDjvB0Goa3OHOWPLcRMUbwqnGxNx9l?=
 =?us-ascii?Q?aVALL8tOIxc874wxfI/x/R8EqErwmmI4W7AurTomwIHuMxwb2ZmWVi3xlyjO?=
 =?us-ascii?Q?3fIdo0aq1rrf7uNkp19WgqN3eCdr4bsoFSiL4hTV8RKX6/wRVkvq71G9zJi0?=
 =?us-ascii?Q?LpBjF5n0FllDZE4/gtq09kBeJS4KvozdkdRa4TJDl8t7dDIuKScPDEpsw9zs?=
 =?us-ascii?Q?qHUCzRsymW9BqZoO5MWk01eHtQnb8Aj7+NQqgd7QkljHYpKrZdYonkRjZEyE?=
 =?us-ascii?Q?YtKgSfL0jSIu7xHW72H1p2K+EaC7XFcqJtVxu0HmV0E/yccEIesbXZXuOK+F?=
 =?us-ascii?Q?quwaev+goo8TSPeEBTucoiFhhBvxc6aC/L7xj7FSTjfwFu8CSXAUcYJ/zvVK?=
 =?us-ascii?Q?0kGK3asA1Ifg2RDbJumHxqtjkNLHVvudV0bv9ZxgKXHmouR/fBJq1ns+GqNO?=
 =?us-ascii?Q?SLVxeX+vGK0CUdY/RvNB+XsEm/2MN2UGKLJx08RkkKbQ3G8RVSvpsnrXuB9q?=
 =?us-ascii?Q?cgJv6jvYeSHw9JhAyPTeovTgd5ztzsAjLexfKx8mg0tvK2veY2iln1XeHdiq?=
 =?us-ascii?Q?/Yra2NTb6NJw9UdyP+TcBbRaZsYiB2WbXnmzWHk8Scg3aqXtno/UXkwJ7D0+?=
 =?us-ascii?Q?7U7MhrWF5+cVYffrZ4AUKCHjnFPyoBZqON8sxZ4+At0BpN8BEU2ccC8coBHe?=
 =?us-ascii?Q?K0kZfZHlLYWdwJl/JrUCQq3GUYvm70F5iqU7MXY63UEZWtdoqZ/CiPfwRtO8?=
 =?us-ascii?Q?crmckadz/6DiPynkP3vimqZLVNuP1IB/ml1pb6tHpts8pZEunPLTBVTrpgB3?=
 =?us-ascii?Q?0URjEYqaBolU4VSee5ltwcotgoMEhIxbT8wHoNd+sVlWiWRGHOI3xlzne0mB?=
 =?us-ascii?Q?fzQ0eVOqwMTJMaU8vNANGUagtndGf51XZ0scVLT2wXOD402EDzBJ1xrlCfI4?=
 =?us-ascii?Q?MVPV9SUtmDYzK6rkTCWYdgmbrGeUcy3b1aBE9wCwG12oEopsNDmyBBEJhJIb?=
 =?us-ascii?Q?xzKjMicILViQUG3xNacZTBUd4xNb9VwCdNhzkV/DZ47NU+s/oXnTaGTqUzN5?=
 =?us-ascii?Q?PMXY8TFbD9B0tCOUGG9uUbrtI8N7iKDNrLmRGRPk/J2VsKLjovEkmPI2gjk1?=
 =?us-ascii?Q?RSW9meSSIabcsrgh+Kr6i1RlSYxMSNrCltNsCHw6zTTdTW7Kdrzb8IBHTTUC?=
 =?us-ascii?Q?6gxkDDyw0dXwbbYGTQG1eh0TVYDs?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea5c62a-dccf-4766-0169-08d9298e3c46
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 08:28:32.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msrmd7M2Ti8lKNXjiHWFWQFsn6Z8AVuPU0gx50KNRqG61JqKMRBDxlNLF6uI6dg/YYMuOc8SfPEBXskWRFEjNOlB50QkqG3NgDA8aBq/18o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7438
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 06/07/2021 12:29, Vinod Koul wrote:
> On 18-05-21, 15:25, Olivier Dautricourt wrote:
> > This driver had no device tree support.
> >
> > - add compatible field "altr,socfpga-msgdma"
> > - define msgdma_of_xlate, with no argument
> > - register dma controller with of_dma_controller_register
> >
> > Reviewed-by: Stefan Roese <sr@denx.de>
> > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> > ---
> >
> > Notes:
> >     Changes in v2:
> >         none
> >
> >     Changes from v2 to v3:
> >         Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
> >         only once.
> >
> >     Changes from v3 to v4
> >         Reintroduce #ifdef CONFIG_OF for msgdma_match
> >         as it produces a unused variable warning
> >
> >     Changes from v4 to v5
> >         - As per Rob's comments on patch 1/2:
> >           change compatible field from altr,msgdma to
> >           altr,socfpga-msgdma.
> >         - change commit title to fit previous commits naming
> >         - As per Vinod's comments:
> >           - use dma_get_slave_channel instead of dma_get_any_slave_channel which
> >             makes more sense.
> >           - remove if (IS_ENABLED(CONFIG_OF)) for of_dma_controller_register
> >             as it is taken care by the core
> >
> >  drivers/dma/altera-msgdma.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> > index 9a841ce5f0c5..acf0990d73ae 100644
> > --- a/drivers/dma/altera-msgdma.c
> > +++ b/drivers/dma/altera-msgdma.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > +#include <linux/of_dma.h>
> >
> >  #include "dmaengine.h"
> >
> > @@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
> >       return 0;
> >  }
> >
> > +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
> > +                                     struct of_dma *ofdma)
> > +{
> > +     struct msgdma_device *d = ofdma->of_dma_data;
> > +
> > +     return dma_get_slave_channel(&d->dmachan);
> > +}
>
> Why not use of_dma_simple_xlate() instead?
I guess i could, but i don't think i need to define a filter function,
also there is only one possible channel.
>
> > +
> >  /**
> >   * msgdma_probe - Driver probe function
> >   * @pdev: Pointer to the platform_device structure
> > @@ -888,6 +897,13 @@ static int msgdma_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto fail;
> >
> > +     ret = of_dma_controller_register(pdev->dev.of_node,
> > +                                      msgdma_of_xlate, mdev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to register dma controller");
> > +             goto fail;
>
> Should this be treated as an error.. the probe will be invoked on non of
> systems too..
Ok, i'm a bit confused,
in v4 those lines were enclosed with 'if (IS_ENABLED(CONFIG_OF)) { }'
when you said to me that it was already taken care by the core i though
that of_dma_controller_register will return 0 on non-of systems.
Now i can add back IS_ENABLED(CONFIG_OF) or discard the ret value.

>
> --
> ~Vinod

Thanks,
--
Olivier

