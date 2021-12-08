Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62946D778
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhLHP6T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 10:58:19 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:33008
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232082AbhLHP6T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Dec 2021 10:58:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG4nc7UZ3iiPvfZibLDl6Au68dbmTOy0vRWFjdBjeORUsNkfj2f4xmj25fMQcaPLKxK5Qc08d/kgSqqubJPQ2xL+aUTpRgaktiGDrTEUfYt+YtfFBcbzqB9WY9FvQ9QXcYny5y9HTJ0unN9siYl47sX3bJkeDYfAhdFEruH81hJ70CrAxbGHIcxl6L3hgeR1N7ZaMSe5mJBJkniA/afIoHkV+/lK9u7cQrBR+eRa8qK2GwbrsPTLgdKVsezkouP2MvuuPXY7yUgnOvdh3HbVRVXU+OBebfMj+BVTkVRe90CBhcoBEkZAadTT9aAQOXwDsgPFFkaVu4Vx4L66h2doWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S9D9HSbenoCsZdgUbSLEczlESblMObwYdCamPqNeJ8=;
 b=PjjDI0xD1HLaoi8LHkIpVahr9daCi4beokar1D/voM7+FZ1YUPmGsacJZp/s8p0fyCV3FVHgqThvQQwNGhk+WAbYungSlRn3NIap/cu5WzZDYQ36yssfTghPfCNmmjyM/oNRL6tAkuVlNhYFIUxwZ9Urv3WkQPpJ1NrDgT9Jyjadw8poapkYTttphDZQ1TcVrRVV4XNWtSQGTPJSV/heIjK+ZASHvFBCMW4m9BngfIXmFR0PHo9/LSG5uuo8jzOxBFkB51Wcs7nY/YTqsJyAopbLYfOIoeKTWKgTubGwVI4zYP4SjYjjReizbotxNHqaueE/Kv9vuVT79XxTVn332A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S9D9HSbenoCsZdgUbSLEczlESblMObwYdCamPqNeJ8=;
 b=aUQ9m6qe1hMXRyHlx5vWsyc3oZzRYMS8t8yAvtuBuNwUNVd8OeeKiIKtvz64i6NYloNFMcpp/WR+pY6I0xvn+FdyKdMwICVVVBxBnPLDN59ZWKNi4667SBWMd/OgrBzgbtPLf+IYHEncvwdC4ETbjpBto86LKKr3P3e4AVGn8Wvf1zvUcXFTS42UW+1eNQiVyy+jaKDXmPRXtUtFa8SrRE+jOjNPIsBds52DXu0bee1PcioxS5VDX0rqc0Ctwimxlz6RYTv79gXjo71I17D9Fb5dVsgqJNaZ4PyIeajvBJ0DGGS255qGtQEKI/0x+Ab89HA/dI+JpAY1975QweIMkw==
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 15:54:45 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 15:54:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:54:44 +0000
Date:   Wed, 8 Dec 2021 11:54:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V2 23/36] powerpc/cell/axon_msi: Use MSI device properties
Message-ID: <20211208155442.GY6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.913603962@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.913603962@linutronix.de>
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e04d19-7845-4e12-165e-08d9ba630dce
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_|BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350B3C88F1E00FF1E43B09BC26F9@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GS+LISBVHteK4d841oWu9hKYKQM1y6NDJhhOZSs/2MqNgq2WySGYMofcjJatgfH1IfNYwLWx1q/jJmxiL0b5+081jpBOKsqFtyuZaPNlrS3nbnOWBfpmoFvttzqdLqnm2zp6Z24krj8/foxWBDQdG8Bc1BMc7jzZMMbijdIPDUZXKMgloTuhMdy898Kf7gb+TV4JWRMgcrQW6q8zAwZjdCEgUELQQDsF2O3MSuBXumzYNYiSfqTOD2P8WEbzfj90pIj0k6Vcjb9ZFP6ccMvv5esslnYauYanDtx4HAwE0Tw7rndk+X+BaxjaVbTuKocXxIuQj4qxMLwooM4Of+2oPzLN7mCmWp7mfPSJxmpeHYHSiW6oGW2nDjxOn+lNfkOufF8woHPsvmnDAhNkkS3sN7KlIyOsgRLM6K97EJgE05Q1W48yTOwOm6POV1FlSOnpojoxPsXnbnV1R2Eb51b5wZgPofDYGkjHqXgv1Twhqn0ck+3dLYmuCjALr8MTT5a3kwT+d4ClnrXlVG0gCMwiwsOZSVztjEMHsLIjhvOPDGbYHo+19lo3WqGiRsoIoXgg+/n0uOHyDc1pHp+dXbzJV3YJr0s6p4rUlk+2LeS/QwP8llv33W+i2c06aCQ6D7fQy5ia1v7MwHprPWGelAgUVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5350.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(316002)(6512007)(558084003)(66476007)(6506007)(186003)(8936002)(66946007)(7416002)(54906003)(508600001)(33656002)(1076003)(26005)(4326008)(5660300002)(38100700002)(86362001)(6916009)(36756003)(2616005)(8676002)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMIbCOUusUhlSao/i/r5Za3Hl4BbRO+/ixs7S7Sbyo2qpr0bfkFiQlTn5Ukp?=
 =?us-ascii?Q?P9Qt4DdTE5PVo3yyhRiGRwhkA68y/LNtU52Fziau3Gl43RxMGaWptIwDIVDI?=
 =?us-ascii?Q?k2WAigMy/+uhzZX00hUDaobg5b3oHxuJ8hohRAV1v2GiLYYtM0ynZnfQQjAB?=
 =?us-ascii?Q?mlQalBjVF9cK2gjSezEAuDeHRMUbYeJ/OAaOGZgbW++PIeAbhw2UI2e0+ZX8?=
 =?us-ascii?Q?xVoUHeZoTP2UCEqqOUZbUEr6SjFkrEELyw8rS772rL5FXDa2XDp1qulBWJWG?=
 =?us-ascii?Q?R+PNZT8sIAdB6sFbvcpQjBq3OIwiZdCFvLe1ElcjRV54q5hOV2cBtmQE+lUn?=
 =?us-ascii?Q?fsXDKKt/C41q8Lv9cn1hw/3jW+fQI7fqzdozXgN1elLr5QiaoItKrB7YJItE?=
 =?us-ascii?Q?n3klZpFCv+p5y7Zker72MVCfRQXWzFXMSWZGJZWpKG7ahQF/OOIa9kc1UlXH?=
 =?us-ascii?Q?C+0irnLb+NSJiTLh8/xTRgufYznCzi4qW8GFn9ACMF+nNqqoRFQdwsJhsrR0?=
 =?us-ascii?Q?/EP6Gq9ufz86gsxSELLy8FLuUt/eo3Dpu6PZTeArAvgu4oPLxgYPgplFYnKG?=
 =?us-ascii?Q?nh9UJuW9aZnQEhPgcWruA5/EpYRuD+7FCTEXEgsmDJmGazfBa39WP+T56tfW?=
 =?us-ascii?Q?zRDWAxxBaWavK0tl/o6lPM27fgXDmntYqlNvEzCssNEyCOxpY3WKpPrnsJ5T?=
 =?us-ascii?Q?pXOJTJoHiP1jwIolm2bNVxgChb6CCxiJb7ZhRtRDUDRxYxdzAEDRV+IKb2qB?=
 =?us-ascii?Q?E/sMcNssiGLgWKB7tWVCc3IUI06cg08cOLUF8m842WhBNP1Z9pMCMD62WUq2?=
 =?us-ascii?Q?GlpIqSnJXfRnEnW+j7flQyCbCtvniyCu3M9X1Hns9xZK5ZUepyoHe3G7Kqfp?=
 =?us-ascii?Q?9PDTI0+z7ad1WLMaHctq2qtP2VO8o/+RNr+D/s4V3GCUYX4lSCp5tHPhnIRt?=
 =?us-ascii?Q?Uvg4HlKUsc/Nd2ywAUPiLeUAusZCygcQ3TZ5FV4vnCq9o2yp3mq9JS/czv7P?=
 =?us-ascii?Q?UeExS7EPn1SNq/toVVFsrJIUHSGTACMS/cs6nd3sqw9d+ClI4hneCyvgoPmh?=
 =?us-ascii?Q?b9tpH/eWfC9xVWCZsROJcNNdAnXmScNfR2pFeE8BRdyccMIWx4h7j7icAjqG?=
 =?us-ascii?Q?nLHhcdCbPo/q0L5SQvBsmFq/FGMvyKWdSEw/ED/5VXGksXQzzNzTta6rJlT9?=
 =?us-ascii?Q?OkpgW4qJC9dywL5uM4P9VisOMDYOyt8KnRx31pd9/ZwtLa+lh8qDbOc31YqY?=
 =?us-ascii?Q?D+GjF782BlTG92LcBSp7oWfgMsWJYtP+8VOS2AWRCOZa5lytxd04bvtYNs6T?=
 =?us-ascii?Q?UkSNUVhhiRF10G3Rlw/JpO4kyzLgf8Ds6NNlhxqVH3uxbgIrgIpJu0AZiGJP?=
 =?us-ascii?Q?t7wVlvw7mrfPuWXtQ1Zof62goARD19menGb2VBfHI5b6L4shE80B63Q9HftX?=
 =?us-ascii?Q?YvR1UKWxtdVpUJ4mEPASzpGNgopUVUgnpvgD7k2HCKWk7X04uXKKFpmUQS3E?=
 =?us-ascii?Q?WVKPedGQ2DNhrVJa0Ai8mExItSbcOB6/bfC00EY5gd4OTc5qND8cFWAlJ9QJ?=
 =?us-ascii?Q?Yvx8MltJjTvXH9tiE6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e04d19-7845-4e12-165e-08d9ba630dce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:54:44.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmTBmT44qbdWtuOamRiWQCTPBIWAzZjS3q0G0peziap0cWI7ghEGY/geYwduYXx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:33PM +0100, Thomas Gleixner wrote:

> @@ -209,10 +209,10 @@ static int setup_msi_msg_address(struct
>  		return -ENODEV;
>  	}
>  
> -	entry = first_pci_msi_entry(dev);
> +	is_64bit = msi_device_has_property(&dev->dev, MSI_PROP_64BIT);

How about  !dev->no_64bit_msi ?

Jason
