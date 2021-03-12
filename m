Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251BF339033
	for <lists+dmaengine@lfdr.de>; Fri, 12 Mar 2021 15:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhCLOlo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Mar 2021 09:41:44 -0500
Received: from mail-eopbgr700044.outbound.protection.outlook.com ([40.107.70.44]:63489
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231448AbhCLOlQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Mar 2021 09:41:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMIxTiz1JCBxxTsbFFycABnF77pXExan/vNRbw3vRj6FRFXc6ZD1jwZBbOzUt1JV+rMQhVr+wQ4ZheYRxoQMpK47gco7HklHJoCr24/yvt0FtcdizbbUucIim9KDBMc0lobxGGu0hnxyYn8TO+1HgbE3rrgNMRSeMFtchhFADdQwxdUZFcv9Qu8bZ0cpkSo4ndxmNMHE0io4HVkXarALVlo9RYRI2Gei6OGGuHFBlHY2nQMKYV9G4LwwiLiT/dzBYP+BI8STzX5RSQVUuKI2bT9NNqeLcU6Ir58d5PNCVcaBc04/Vsq3NYietIRGrTOzlVSUyDWHXz+X7sZ5fFC1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMTOroG1uO6Wldv+WtLZqjz8uz9fUf2CI76BALIapkQ=;
 b=gcT46nfr/pGXRP1QUn85xLTkfJz1GcLxN90wF9zTABbqb6U2f4+cz64pHzcICWFSwGWFPYzWkuvUwj9lFhxy4+MNsl90aih8NGr6POfSecUNDFuNkqIwRGwcc4Gy/rTqShJvfTQyoX5dagupcLELZufY7ZDCer1cbTVqICkyabg7cUvKszuv9JV8ujMccz9UTqn7JHpXsz7HeWhsZvdJ/ErEfgMOSFPTCEAuhu3KkHulEXBnRymBngUCeW+LhRUG2gUwpVjqrGCfOOG5CwDmolYL7C6HRZeG+q/S69A7dXSRyX7qPqIc2dE1DTSqQt5T7pOb273dkX0nbreBdt6Pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMTOroG1uO6Wldv+WtLZqjz8uz9fUf2CI76BALIapkQ=;
 b=qJk8iezkhh/RthshsnnY4ZLfJpmTGrnbSfbkdmWn6KwrJsOJcf08262WLDRBxOWIjyduud+WD8Af1PAqGHwkNpmfq/DI8t/uAL9C7N4ImNLxVPi5YS30/FB4tEwAyk0bW8ArWQUNr5oHUz8FEdxD07ujh56B6V+YqEKX256c/lfgd1L9CeM5WIWNjfEU09nMxFGbx88Ai0gI5v/DZyKDT3Y+wKxcZ42Et+AFo9HOTGL/XVhGz9fCg93msQgzwnfqneA/F7LScasuDtMEr9vm1+psuk0Wk3wrXtqhVNMMVLv9PiGsy9Xp4CmpmVnS+bP+OVwP7QH85Sm7pUVUYJVhtQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 14:41:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:41:13 +0000
Date:   Fri, 12 Mar 2021 10:41:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v6] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210312144111.GC2356281@nvidia.com>
References: <161496196189.574379.14498335339906166138.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161496196189.574379.14498335339906166138.stgit@djiang5-desk3.ch.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 14:41:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKiyV-00Bw0w-SN; Fri, 12 Mar 2021 10:41:11 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9a50a1-406d-4423-0b5a-08d8e564e271
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754CD3D09064220909D6F41C26F9@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1wVIv+z4Aoktoq/rs6Rk9OE/KzgGyjGb4sEIbWSEWgPEDXcOqU/Fu6wq/IETCt4lAdKlf3iY35TFBLh06hAbMsB76nSY4JDKdQwqg2VqU9ok6hKtBBC4EnWWwDtqX5HldXup1YIT1iu12cwjAbQOIRiCH/JHxzCbRZ5i1LUF1kMsoXn1zZyIkkisdXISYv/Z2QrpXGDz6q656SfYiaoUCKlznRQOwxjGOJJkQFaVlqFmwk+m+L2qJ7ZWXE8yTZMxzsLc32fBLoq0Y2lmAUIsxYJPQougsE+FANJ2mtHIjSNdgN226W6qVpfT1I5AvXu1X/73Y4BPZ8p+y3cs+w0ib1K34dIhFO5y9CeL1rdap7wQ/TofGgqHhdJ3IAiW9cAUomYJGJfsDxLuJs4h9qSchcx5Suln80/WC5VTJim2+ILWhNHGbkOaDhgcFfdD4Opjl1h824HZh8kp8lttBfBDp1gIw5D1gTQb18oBF954RdChOlgDu/u8nwMvmESh9Q+IqZGQ9PWhPwMpUHcxOF6mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(6916009)(8676002)(426003)(2616005)(8936002)(66476007)(9786002)(316002)(186003)(26005)(2906002)(9746002)(1076003)(86362001)(33656002)(4326008)(66556008)(66946007)(36756003)(83380400001)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OURuRY4Ogoddc9JOMRRq6QeWv238Ttf43pgxbV9qUFLtMvizQo/kWBocazXp?=
 =?us-ascii?Q?ZphnuB96AhNpCdCJjp42gsdL/b/U0S6WUsjrvTYaRRSEhk2+cUfDpY8TgUlf?=
 =?us-ascii?Q?0OAp0sHmiTy6ab7dEE3KgDkrzXGE4GANyqbIX737qEtIVmuhmGcLjBSWs5Mb?=
 =?us-ascii?Q?JTSlIRqItpJYzhK3Gp3d3NvdVYWNA17AH3fkx10yrGZ2UPIULP4Lz+Hauh75?=
 =?us-ascii?Q?X0kEcTgA0e3QJ7Qhl7YjekpSCurnYsfsjtYq8MSOiDRG2TvMYHjtJ9/PumjM?=
 =?us-ascii?Q?bpQKNmPWo8WJF8fiJDfRi6ra5TrMh2uJiOng66CGqwuky+9BIBD3kJLobz1K?=
 =?us-ascii?Q?ZJ+mkLGRpaAA2j5y0ZHIiSk6AAmcNVMNhyHw8s3dE9quhYKSHtTqzVDB0sGf?=
 =?us-ascii?Q?lPWDXw16m95GEfpyuZCO7bdtJZ/r1rfZxnhfDUPs3tlGQDZtFCg3l4XFBNE7?=
 =?us-ascii?Q?fZcCm3kjD4Othr0YbNnAINQIty8TMbW7RHytwcuZFqlkQwKvQuEggP3pYUFJ?=
 =?us-ascii?Q?gD/uabYK8YdxPw4ojUNQUlSUvGr1RWAaJ9c8bZ3y77oqmNhf7dXXi3G8fzPZ?=
 =?us-ascii?Q?UxLxZR8lKLis3eNNA5ujaTT5W57me4kxmbdoZjt3sjn0nZQrcTT8PiI12pdH?=
 =?us-ascii?Q?X9HqvWzVwIA/4X0lCxqRfTZHAB02ccEtW6oDwqp/LcET5Zmvw5Jw9uL14LnO?=
 =?us-ascii?Q?GFHwy/+sADb6mu3N81OxYUBgWVAY/MDVyUIeG+VYSP5E1jZYkUoeXYS/ck2h?=
 =?us-ascii?Q?kagwdykOcwlccLkinxzEwdnh/QBmsu7eBGJCwUwx+1khdPb0ABAcG+ZKR/x/?=
 =?us-ascii?Q?7ErDM5MudCRxeox4XDc1bb8qGBuEdlXVKVXeYtTG0x0GpJSW/HY3n4jZnrPW?=
 =?us-ascii?Q?WCU2zrKpe5p6O94WdqYLiZNLBpUIERfyZdB3KgIYFwCMNOESdnDeCC0Kz7/b?=
 =?us-ascii?Q?rDXiY5bqp9m50XFoS2dW92BJ+QD5mh4qYGM4fbiEusN2Iigfy/6Ne/7RQ8Xv?=
 =?us-ascii?Q?532WBn1SxIbaLaAXrEgZgw7JejDvfQMYCldzWpO+vtVUdBjZrQEcrxOIH1wl?=
 =?us-ascii?Q?pmFT74oLfBR8lNsV1cIhFPyodMuwyuyeSK+PTeDcE8UzWGZJCX9iU+qYpEwW?=
 =?us-ascii?Q?35c+ZMRqp8IQEvBS6u6DYISaKiXzoNxh4IUVtql/1apNh+bS+fxsdzy8v+kf?=
 =?us-ascii?Q?2jbZ5uILjhFxSszeMhZJyfMGB+akBSpQ0AyKkR1moRFQGbFn63we7e6BsNFz?=
 =?us-ascii?Q?7fx4jB9tyjeooA6rXs3m/0GCA/ioZITOwwZdQrugF0wRd1OnCb1/OG1St+bK?=
 =?us-ascii?Q?7xsIMBOHyR4nSYoN6UCeWeNWqRHzkCjJUCm0CkbiN/YRkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9a50a1-406d-4423-0b5a-08d8e564e271
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 14:41:13.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kgno81amTElcUOCgRD/4gn0bf6qEposrlVVKqk3KpA66yZYvE/ZeBKIzk+MuyZ58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 05, 2021 at 09:36:02AM -0700, Dave Jiang wrote:
> Remove devm_* allocation of memory of 'struct device' objects.
> The devm_* lifetime is incompatible with device->release() lifetime.
> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> functions for each component in order to free the allocated memory at
> the appropriate time. Each component such as wq, engine, and group now
> needs to be allocated individually in order to setup the lifetime properly.
> In the process also fix up issues from the fallout of the changes.
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> v6:
> - Fix char dev initialization issues (Jason)
> - Fix other 'struct device' initialization issues.
> 
> v5:
> - Rebased against 5.12-rc dmaengine/fixes
> v4:
> - fix up the life time of cdev creation/destruction (Jason)
> - Tested with KASAN and other memory allocation leak detections. (Jason)
> 
> v3:
> - Remove devm_* for irq request and cleanup related bits (Jason)
> v2:
> - Remove all devm_* alloc for idxd_device (Jason)
> - Add kref dep for dma_dev (Jason)
> 
>  drivers/dma/idxd/cdev.c   |   44 ++++----
>  drivers/dma/idxd/device.c |   20 ++-
>  drivers/dma/idxd/dma.c    |   13 ++
>  drivers/dma/idxd/idxd.h   |   43 +++++++
>  drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
>  drivers/dma/idxd/irq.c    |    6 +
>  drivers/dma/idxd/sysfs.c  |  225 ++++++++++++++++++++-------------------
>  7 files changed, 393 insertions(+), 219 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0db9b82ed8cf..56143336e88b 100644
> +++ b/drivers/dma/idxd/cdev.c
> @@ -259,34 +259,29 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>  		return -ENOMEM;
>  
>  	dev = idxd_cdev->dev;
> +	device_initialize(dev);
>  	dev->parent = &idxd->pdev->dev;
> -	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> -		     idxd->id, wq->id);
>  	dev->bus = idxd_get_bus_type(idxd);
> +	dev->type = &idxd_cdev_device_type;
> +	rc = dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> +			  idxd->id, wq->id);
> +	if (rc < 0)
> +		goto dev_set_err;
>  
>  	cdev_ctx = &ictx[wq->idxd->type];
>  	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
>  	if (minor < 0) {
>  		rc = minor;
> -		kfree(dev);
> -		goto ida_err;
> +		goto dev_set_err;
>  	}
>  
>  	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
> -	dev->type = &idxd_cdev_device_type;
> -	rc = device_register(dev);
> -	if (rc < 0) {
> -		dev_err(&idxd->pdev->dev, "device register failed\n");
> -		goto dev_reg_err;
> -	}
>  	idxd_cdev->minor = minor;

The error unwind after this is wrong:

int idxd_wq_add_cdev(struct idxd_wq *wq)
{
	rc = idxd_wq_cdev_dev_setup(wq);
	if (rc < 0)
		return rc;

        // At this point we have done device_initialize() only
	rc = cdev_device_add(cdev, dev);
	if (rc) {
		idxd_wq_cdev_cleanup(wq, CDEV_FAILED);


static void idxd_wq_cdev_cleanup(struct idxd_wq *wq,
				 enum idxd_cdev_cleanup cdev_state)
{
	if (cdev_state == CDEV_NORMAL) {
	} else {
		device_unregister(dev);  // But nobody called device_register!

The 'enum idxd_cdev_cleanup' is really gross, you should avoid that.

This feels like an error that crept in from splitting dev_setup and
add_cdev wrongly

There should be two functions 'allocate' which brings things to the
point that 'put_device()' is the "undo"

And then "add" which does the eventual device add.

To get to that model here you want to move the ida_simple_remove into
the release function

And you need to split this patch up

Jason
