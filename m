Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA839DA0A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFGKsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 06:48:03 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:46210
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230454AbhFGKsC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 06:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpT21w+vHMBf5Fi9cjXxjCh2Th41ICcm1SgvRNABnO+AwPVvtHZEHcKNqMEsxYX3kp+3n65mdHtG+HQv1UOT0YKxqvch3v6SccVPzckeWkbahbUfhdoP1swWsxzAiCRGkXbYcyvKyiF8NjiSoms5WF69lUZzlNBrBWIrmTNSLOvNq7R8WZdC8mMsJF0UFNTNHZtydFqYeE4bZfNY3O0PZrc4lSjlW6mKD+2EQvfWJbzB2BhFAC6hwkUIaY2oKiYRg/RkRXhp0JOIj3m1D40xArlemQpIzIRlOTuhznkpJqxWVYaU91PjHseL1Vx+5+IRt6MsKQvby06Cf0sXs9Sc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvg+f4dj6D0Vjz3r8p6tCZ5o6Ez3c4q9VDyOOFrT1M0=;
 b=c2U3lfzUt8hTqYX9W1zGUyL461vpQrqgQWbBDamk1qf22MWbxds8D1QH9cPlHPPTVakC11+9XCENEQK0Rs3gz8lSDQRR61dBZWKE5K7z8VhqE0zrzC9CpO2NNoCaVu3e3SibXMqstkxrNhbDDL9L1SjnzuP8o/3IktNYLxXjM2zQmr3o7OZ29chXpdl7H22kT2+zRaUg4Dv+qfZnn7XSYQufEsypbs6/rqhEQhFJ99MFsKiWRaEyu8/ejWsCX2wQ6eUZ5YBEj+olUiy8ybTqs/GJb8Bu4x9qdpwFssNiPh/BkinCNeGjdfw9nxR6b4xMjMfeDbv1Nl4OEr4WxhOqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvg+f4dj6D0Vjz3r8p6tCZ5o6Ez3c4q9VDyOOFrT1M0=;
 b=peDEt21+fE+h8bMfTZT9Ck4J/eLz8QkdWy9Ha1ktYl8uPxrY0N38w+j12z/7WvfWvDqFDnljAiNyEtalLJLLvHUOMscO5Eg0X9UNwt8g1MsCwxBohPYCE11GRoT4d+jJEwiOOIuEGEQhefg+UepIsE4l6nFOITSvKz2I24HChM0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB8234.eurprd06.prod.outlook.com (2603:10a6:102:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 10:46:09 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 10:46:09 +0000
Date:   Mon, 7 Jun 2021 12:45:48 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dmaengine: altera-msgdma: add OF support
Message-ID: <YL343OIeVZe0Hvod@orolia.com>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
 <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
 <YL3DvQWhn+SsBqhJ@vkoul-mobl>
 <YL3Ynm9xBQ419qK3@orolia.com>
 <YL3wOT1B8Qp+EXSV@vkoul-mobl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3wOT1B8Qp+EXSV@vkoul-mobl>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 10:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839486ec-1f7e-4ccf-efdd-08d929a1758d
X-MS-TrafficTypeDiagnostic: PAXPR06MB8234:
X-Microsoft-Antispam-PRVS: <PAXPR06MB82344E8A2746E1984555FD6A8F389@PAXPR06MB8234.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X82xt9TKVHB4qfu2f+8Pf2wMOcsu+iZEZM/PnzdNRWTpFE0ZYc+I2RSC+6QvhRxI6FXIddqMTlFjjk8IUn3Dblg2stbtn4hA3eIRR0AgUXy2nWkBo8K3fM4OkTxDrRlKUNW/6ocOvxJycRiHFprdolCXy1GrZLrjYbN4Uj8JOE+ydh1xQ2GID6S7P8LlhPHZaVvj6TdH8LfH7yNMYb+fd1CfB95kmnpg/8KiTqyAOIL7ZzrLQGNqgVXM0LqtVE5KMhOqI127qpb9+AkcLsP3AzCbGXmWqGKiwPJ+DtsEJG93eN3eq/tWzy2HFLigg0ZVbCZ9pNcib5R39yudhB0vjNeuB6zhFhpegjvR5w0SF7LiQJRc+7RO/645Rh4R9ZZqBwg20kU/2qlnEJK6feRB3OHPk+G16mGmGClx/oyCOwIg1bbj/w5OlKgv8jRnKk41O8zm3WGaPJSOJSemDZzmRq53Y7Yle6Rb/XScEgx+nmn5fQEZvYjin/H/qOzyfBI6rTfx0JYaWbUw1aqivcwzmlm95N18qRqSDHW3HbcjRlW9dGK9ATe5sDjIZY3lvrhhxZz96gjWpJcLMQyyHs7pNYtAWZigrt2Z3f43aTZPan0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(83380400001)(2906002)(4326008)(6666004)(38100700002)(55016002)(53546011)(316002)(54906003)(6916009)(44832011)(5660300002)(36756003)(8886007)(2616005)(7696005)(478600001)(8936002)(86362001)(66556008)(66946007)(66476007)(8676002)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ED44YWdZgB00LUsJ5NLSPCdAJ1pV4Ch+oRtlUmhpYg4fUfGeHscRBcFp272H?=
 =?us-ascii?Q?qJLNxUPwovYyq4sgw+j3+sE5aUtovxUZeoXuhO+XdZ6vKvzIjXulIuDZNE2p?=
 =?us-ascii?Q?YXU36AC0Iw9nJ8ZHRZmIQraUJ75dp3KXcdz3vgDFRzV1kbUCAd1eXbqYP0oR?=
 =?us-ascii?Q?g132utAwl/FN2L51X3YR7UWkFkJsixso/bY9p4iJ8wEJd/TXCuQlzsQn3lkZ?=
 =?us-ascii?Q?ZzM3QMMCBFqcKSYz5DbtUeBZd6wrEmjg0QGMUiXBTAHt5xqMFghSTntkd8ot?=
 =?us-ascii?Q?w539Dr3T4wHO9GdRncqjkavAXW2Hr0di2UUjBOJ8lZ7KZxlY5DV9vzRFAgNh?=
 =?us-ascii?Q?oJtSg8TUG7eUJOgM4ij71GZD792UlTEax0GXCRUv5105d7HX0wvrWu1wjqI3?=
 =?us-ascii?Q?Q713tsbJNF0UpcLDdub8H7ODyIN6kgpiM59c42AdCdQZ7CnRGUDWjhRYC+m5?=
 =?us-ascii?Q?67ccsTyHviPPBaSLV9NEXtFyE0HwOSyUs/qb9untLtUBHJtu+ReAPh8IjvgY?=
 =?us-ascii?Q?Rve4qLfpNVfb3nOaP7SFqDeOIl0HvG3RQ2Q+73eOn+oCf4D2FKRhLlg9Kq5e?=
 =?us-ascii?Q?ufcC5tJI546RmByZn19SsbqDAHLbYHwedZofayO2cQHHAdu4wIvkyKdRvwq+?=
 =?us-ascii?Q?b2DQEKFaIIt1chaAd9bi/h0SHTFtdCnQN3ra34XI1NahlWfbool/orPFjiOb?=
 =?us-ascii?Q?A04jEz/Unal9DlSsxOP0xKz+Odz+L6DziqtOe+TI1kzDb9a4kPr1x/WyTF+E?=
 =?us-ascii?Q?UnhuUNCrQCl7dhh3ifesfJQQyHdKQENzlY59aoT4nl42VymZp2pjo0oshUfQ?=
 =?us-ascii?Q?ry3QlNM8AiilXa6om1xn4TP68nZgyVS9S5nscg47wQjtNPeQL7uqStYIqdT2?=
 =?us-ascii?Q?VKt7yB0wFoPdU+bMTDbxFGmDh7VFBEJgmclH+SoqYUGsl+3QbOSWBnbczaRl?=
 =?us-ascii?Q?lgUYBlpu5mXgy9NTnZs6QiwpD2rOiRuqbY+JHYEjvnTIaAUlYLfLfIg1jZe5?=
 =?us-ascii?Q?nvBz6ICegkjUjFF2q4y6jAHhdD6+tJcLKgf2EqPEyGSZfhP/v+kNwhGoeiYy?=
 =?us-ascii?Q?FiOBiphFiy2sgtGJRF5wwtc5IT1zwbx5VcxPlq2MW8nzaAxxfSPVmjSejSaB?=
 =?us-ascii?Q?FgqOfAIplrhLkaqnF4G92mdPQx1Rm0v/JAb/UaWtvcuxhEyDGvT5xpN/G2K0?=
 =?us-ascii?Q?D6CM69Zvn104qkVAaYsiwKaqDpCU4LincCIDvda5P3IuUUjVWIpdPvJujrzS?=
 =?us-ascii?Q?8WurTArC6svN+Ig3bVIzl9J/f6Idm+bQoGQACf+6rOSbxL083E0mkh8kCg2k?=
 =?us-ascii?Q?4zADApOnDkH0YhPkiqnG4DlxNNY8MC8i82Zb3BzMolfoWMkie6kJrHDbHQ8B?=
 =?us-ascii?Q?SDVvtePlJlgpnjxbYpjwV/dk7e0W?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839486ec-1f7e-4ccf-efdd-08d929a1758d
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 10:46:08.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3eWuTitLiOqKQUJqhlzu2Hv3HkjzPX9HtYPjfREnLTVQhzZJlIvKrX8dPLEiKnhoWWBgKPgpSLN3Oifxo6DL7m7xpWEtRb+t+w7BQmK1Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8234
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 06/07/2021 15:38, Vinod Koul wrote:
> On 07-06-21, 10:28, Olivier Dautricourt wrote:
> > The 06/07/2021 12:29, Vinod Koul wrote:
> > > On 18-05-21, 15:25, Olivier Dautricourt wrote:
> > > > This driver had no device tree support.
> > > >
> > > > - add compatible field "altr,socfpga-msgdma"
> > > > - define msgdma_of_xlate, with no argument
> > > > - register dma controller with of_dma_controller_register
> > > >
> > > > Reviewed-by: Stefan Roese <sr@denx.de>
> > > > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> > > > ---
> > > >
> > > > Notes:
> > > >     Changes in v2:
> > > >         none
> > > >
> > > >     Changes from v2 to v3:
> > > >         Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
> > > >         only once.
> > > >
> > > >     Changes from v3 to v4
> > > >         Reintroduce #ifdef CONFIG_OF for msgdma_match
> > > >         as it produces a unused variable warning
> > > >
> > > >     Changes from v4 to v5
> > > >         - As per Rob's comments on patch 1/2:
> > > >           change compatible field from altr,msgdma to
> > > >           altr,socfpga-msgdma.
> > > >         - change commit title to fit previous commits naming
> > > >         - As per Vinod's comments:
> > > >           - use dma_get_slave_channel instead of dma_get_any_slave_channel which
> > > >             makes more sense.
> > > >           - remove if (IS_ENABLED(CONFIG_OF)) for of_dma_controller_register
> > > >             as it is taken care by the core
> > > >
> > > >  drivers/dma/altera-msgdma.c | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> > > > index 9a841ce5f0c5..acf0990d73ae 100644
> > > > --- a/drivers/dma/altera-msgdma.c
> > > > +++ b/drivers/dma/altera-msgdma.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/of_dma.h>
> > > >
> > > >  #include "dmaengine.h"
> > > >
> > > > @@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
> > > > +                                     struct of_dma *ofdma)
> > > > +{
> > > > +     struct msgdma_device *d = ofdma->of_dma_data;
> > > > +
> > > > +     return dma_get_slave_channel(&d->dmachan);
> > > > +}
> > >
> > > Why not use of_dma_simple_xlate() instead?
> > I guess i could, but i don't think i need to define a filter function,
> > also there is only one possible channel.
>
> Yeah no point in adding filter_fn. I guess we need
> of_dma_xlate_by_chan_id() here, I guess you are specifying channel in dts
> right? If not above would be okay
Yes i am, but as this controller has only one channel I was thinking not to fail
if something other than chan_id == 0 is specified. But it may not be right,
I could also remove the argument in the device tree but dma controller
schema expects at least one argument.
Now i think maybe it makes more sense to use of_dma_xlate_by_chan_id and
expect chan_id == 0 in the dt.
>
> > >
> > > > +
> > > >  /**
> > > >   * msgdma_probe - Driver probe function
> > > >   * @pdev: Pointer to the platform_device structure
> > > > @@ -888,6 +897,13 @@ static int msgdma_probe(struct platform_device *pdev)
> > > >       if (ret)
> > > >               goto fail;
> > > >
> > > > +     ret = of_dma_controller_register(pdev->dev.of_node,
> > > > +                                      msgdma_of_xlate, mdev);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "failed to register dma controller");
> > > > +             goto fail;
> > >
> > > Should this be treated as an error.. the probe will be invoked on non of
> > > systems too..
> > Ok, i'm a bit confused,
> > in v4 those lines were enclosed with 'if (IS_ENABLED(CONFIG_OF)) { }'
> > when you said to me that it was already taken care by the core i though
> > that of_dma_controller_register will return 0 on non-of systems.
> > Now i can add back IS_ENABLED(CONFIG_OF) or discard the ret value.
>
> Well including in CONFIG_OF sounded protection from compilation which is
> not required.
>
> Now the issue is that you maybe running on a system which may or maynot
> have DT and even on DT based systems your device may not be DT one..
good catch, i forgot this use-case ..
>
> So i think the return should be handled here if DT device is not present
> and warn that and continue for not DT modes.. Also someone who has this
> non DT device should test the changes
I can do that.

I think Stefan used this driver on non-DT platform but he said
that he has no access to the hardware anymore.
>
>
> Thanks
> --
> ~Vinod

--
Olivier Dautricourt

