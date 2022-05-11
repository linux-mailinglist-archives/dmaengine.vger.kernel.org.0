Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE91523C75
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiEKS3M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiEKS3L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 14:29:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4EA17DDC6;
        Wed, 11 May 2022 11:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pci30UTrD0PAEYEHkUXXw3eDXDJtaP8wqdUuF4506fYGNHQGEWRpMiOVUG/LLBmYHXzdayseS/cOG9MaUEcU0DJA99ddXU3FMjuUMDGJaJ+5yoBAMpq5N9aRwMNgb1ByNBmNIpC9HWQzuFXoqkXoiiy7BaSi3zHZv41qmK/VS5pScHI2U/0g9EZFj2kP7GriiFlLXZ8+9XVgTpyWlt4KMvuTaYiduTm2d7obtODD9xObvO1Nh+jxS5X8/lD8QSkBDTvzw7qaOMkvQeam+uXPdnS1Ai0UkCYzzyzI43+M8Rk1QPYBtLSEF08A+MzZqlevo0owx7l0SMn/ERjktUZmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlaJLD87rBrvp+ngQqFuOwyLsF3O96x6aZN0CDbAMYo=;
 b=R9hoDlSpeUJFYz8d2ctbVc1iR8ltSi/i4JC38wfIdbhcPHcUCTFIx/VaAP0Igwtd78oPlFubPXF/CP1Y+oYtSo6z4dP2wx6rpaZa7LAjrKnAuxZrX6CC/OfZmfZTmS7kawC9rbbaSxU5AigWSqRrveJFmQ/eQQuaOEG6fDCNA2LcWYith7aNmFzkB3vmQZqADafH2pPyJP4WZx3XudqFA2a2Ltrp03WEwUtU+KQtH5/QegN78HQnza/aQOYyu/L1KCnxsCHTQD0KroHsdomZVsn7kbg1ARq2qTgMBCFG1cLkmqgwrrdVLGjG7cqliR7WUugltIq3z0aDwqmtKOoQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlaJLD87rBrvp+ngQqFuOwyLsF3O96x6aZN0CDbAMYo=;
 b=Hsosu568FQtvjqzSjieU6bQr1XhHJb/ncZkn47UdD2qYSeenUZ9glPjDP/TMioLhpyB/I9IX/szKtRRzY0iB/MQ+R6toKa4hB/YxHBKWokFE9e0EJ7l912IFwvPF7V6zZFDlJoERU0kKHAHByRg1di4RDpZB11JLRHQ11kAOSj1tlCfNhqBaCio2BD757N4SdtxPSWoxNOMwFTN/1n1Ol0NUXK8Pllu7jeWPaghH9+3dDhJTiAYQb0eyn9UNlYa+VnTNELrNDOjKxbJpY+msLSEH/g6mpbX9z5ZGyPeZD7PBUrELmL3reCnEHi7a4w/op6qofetJlRrUEFXDeDCaxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 18:29:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 18:29:09 +0000
Date:   Wed, 11 May 2022 15:29:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511182908.GK49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
 <20220511102521.6b7c578c@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511102521.6b7c578c@jacob-builder>
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51db587e-e9cb-474d-cc31-08da337c2366
X-MS-TrafficTypeDiagnostic: CY4PR12MB1494:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14943286F9423FFF3C6E8580C2C89@CY4PR12MB1494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NC5ru8O6HGEYVYy6YTmkbw+0QBVj7JQrGwdtIOdBzcmWGx8zFPYRl6cGSnSAQpf7k+/oPKnPjZQrJ6+2SgkTcIyHInvPrjJhjwqOeElfE25UU+s95K7VR7ggYFquUc6puFwsxhTJp2EacmL6/OVuXqLgwXTX8Dyv8oYMWNGtQh0xfyUv5yyH+MEnOuDUG6iz6PT/4u8mmBffxuzfLshicmJmaGuRKPabSPr3fAOAKqsuUU6DKueVbEv/1dNJPCRJQ5FwvvA9+qhyFmp2enhcPVOFOqvhpUn3sKIUL60cVpwU+0oJ+CwLr1ivTM4VXiWxapIFi3ZkaAp70W1tby9oy2wG31O5Dxk2i0XHOwYMSS39LiRByp96viU1493cu6XvycE0yDkEsHJvjfwzbm+oJKbZJfHScKjtf4P2yEq+ZneT3m344Ee6J+cdcK8OWdGSIwEHFmaKvQ2WtagjMRnnUo8CWzlx4mg9LNbknk4BNxGbFn0Z+LL9KqrleMoUTPkREie19QU2F84QeWuKpn00ZP9GktTaI8UVKaKIKkiMt0Y5LlkOJ3hENRpyK+mkxelcqmEJ2L8I/zlvmni+0A8wUKl1jyU43uuQQh7GEuLdiR5o7fu+pSJI+50c/lUOqtAnUp1uA7p4bHOzAywi+1Grw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(26005)(6506007)(5660300002)(7416002)(38100700002)(6512007)(36756003)(8936002)(186003)(2906002)(1076003)(83380400001)(508600001)(33656002)(6486002)(4326008)(86362001)(316002)(2616005)(66946007)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tK5ITeEJe2QFu3HLLbNJZH4uIMzBFKrKYGhRBbpj9F4jKaGalq5XZxASF8M?=
 =?us-ascii?Q?/G7VCgeZxT7yaejaZ/a61xJPextRxjN7XhzeQPH0cTj4CIKs6iMzQIFEkDAP?=
 =?us-ascii?Q?8qX4H/HPzfJf8XMgWLOy2k3gO+eMCyWKyBWm0CDkwD1NZh954amL3UX3XB8f?=
 =?us-ascii?Q?oUtjteg+JYp0wl3YGL6JLLwjsMm0V3ZBC6nN9lRpEEG119XvQ8SM78ryMIYo?=
 =?us-ascii?Q?SiX40Lymr2BVSS00EyZqXv9dM8tx43Lnf2ZvSFXqoZgIdNa4KKrPJGMSoR5o?=
 =?us-ascii?Q?kv68iU4PBIpEZfAyYaqtWSFXvG/fvcT5/upPAoVZU+G18hYGKMcRioVn4+BQ?=
 =?us-ascii?Q?iaOv0EyDfDGMdLkE+5WhNgA8yAEtnx3UwSF5nDGhByqyHlF1V9noo0Gamywc?=
 =?us-ascii?Q?YSV5P1QDHXwF8a5nDkPNvaBMCXFLVd4ku3WSfGU5EABV2JFumnPJvN36lVLu?=
 =?us-ascii?Q?6EyYJzxWJ9S0ahKXN6UklM/+LVJGjPLmJmtBQFJsI4H7BuupEEMpWSlnwoeN?=
 =?us-ascii?Q?Pg2DfV+1Bk22uoFQLUMOGIbly8y1LlIvvsSOzoK89j1hZ+rRVNEsY9mN3sp/?=
 =?us-ascii?Q?VTF/xwMNUO55MW1S3Tgn5Fs5pGdC9SMASLZSHF2RV2OuocoU89c+9WHuirPG?=
 =?us-ascii?Q?P5upzgu3Pnb3LLPAsVBsi9W36s7KlqrgBbf9dzX+jM0zZQdqS9PBlkOxfB0X?=
 =?us-ascii?Q?TWrcrCMSs7x/R9+nQX8WDgsB+usLOwqlg9GhDoARe+/vNA1roiF5OAt/o05M?=
 =?us-ascii?Q?yX8EBtmQCjj8WuWuNOfeTn6z7fJjUid3KWmSGZ6BHon/tNNQUJQxmnZBcvQB?=
 =?us-ascii?Q?tePjmiv45yiijHv1Wwo/CsZxMqtRrgDEQ7vEQDoAyZ1SbXScBMcy6op4JTVm?=
 =?us-ascii?Q?uTHo/A2FrGOcYNBYSWjh4GpE2+XVqVCo17rINeV0au7s7zyg9DZZHiYDzv/D?=
 =?us-ascii?Q?MNPTDhgYXf72DSp/x4WI1SPQY4Y9o/a6FuUZ+mdJeoyB37LfQOp2fXQokFNS?=
 =?us-ascii?Q?BZKeDvxi5gUuj1qEY1GRb/mFAQY2yO2cLXE3O7q0Z0i8ek9a0HnskkG+qORy?=
 =?us-ascii?Q?KcMO1yzh4iBr8wxrpn1DU5XslhP+Cz298ZSZ/EJJ7XrKsA5uLFgQFWgW+SfY?=
 =?us-ascii?Q?i4jmmwZNJx2Ou07B429N5wt0bDYp7oFT9FEfpPr8DwwXAyFJsN2fdQCQiSJm?=
 =?us-ascii?Q?YZqSH9LDHkDXMsEoH5wUk1yni41fMGi8PRoksUJ2ZCzub2/EsOJK9+dfhhFn?=
 =?us-ascii?Q?xeRO4acuthkCPC973+RJx7zmcJmuW9Va9Hjek1jfbix+qnysNUYmoyH8tC+E?=
 =?us-ascii?Q?y97du0ISgI9M32kwAR3DDWODEJI/RCF+S82WcySbe+YSjdxdWGfr0lnoeC5q?=
 =?us-ascii?Q?Jnpr6oI0/d5PJOIJa9GUGeIbYP9SesbxjtN1qpBwc2Fozq4DNIrWmaSd8sKE?=
 =?us-ascii?Q?1AlU+/eBrLKub/adFu5Kd0O06IMyGfwaOHDDUcM/R9c6CGgKLxr6Z97uGlBi?=
 =?us-ascii?Q?b0qDL0KZIV5wD0rrxkPwqtv8ixD1ZCHx9dmosJ2JsnVUGlymNowPJyME/kGj?=
 =?us-ascii?Q?ej9xVNMhj2p7SdfYLhzhYAumUv/NAvm81AtuW+76i+WaozEqXiaUGN26qMjo?=
 =?us-ascii?Q?pU81uVMCTl8/7YLpd4RPHUel33u0Ol1NcyJUPOwDyJIJX6g/RIBnI5W+1rdx?=
 =?us-ascii?Q?3n0aqhNdvHdrtgTAG7G59OISst5TivGmr1LLVUrQJ4yoWc2mIEniEBFp7Obe?=
 =?us-ascii?Q?P/oljtn09g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51db587e-e9cb-474d-cc31-08da337c2366
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:29:09.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jyvDGvFZ2v8vRtS5pCdb72WQov82O/gqjIeKi37LLpoufpa8iNDoVbkR+aiVnS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1494
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 11, 2022 at 10:25:21AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:
> > > > > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > > > > attached to the device_domain_info. The TLB flush logic would just
> > > > > go through the list w/o caring what the PASIDs are for. Does it
> > > > > make sense to you?    
> > > > 
> > > > Sort of, but we shouldn't duplicate xarrays - the group already has
> > > > this xarray - need to find some way to allow access to it from the
> > > > driver.
> > > >   
> > > I am not following,  here are the PASIDs for devTLB flush which is per
> > > device. Why group?  
> > 
> > Because group is where the core code stores it.
> I see, with singleton group. I guess I can let dma-iommu code call
> 
> iommu_attach_dma_pasid {
> 	iommu_attach_device_pasid();
> Then the PASID will be stored in the group xa.

Yes, again, the dma-iommu should not be any different from the normal
unmanaged path. At this point there is no longer any difference, we
should not invent new ones.

> The flush code can retrieve PASIDs from device_domain_info.device ->
> group -> pasid_array.  Thanks for pointing it out, I missed the new
> pasid_array.

Yes.. It seems inefficient to iterate over that xarray multiple times
on the flush hot path, but maybe there is little choice. Try to use
use the xas iterators under the xa_lock spinlock..

The challenge will be accessing the group xa in the first place, but
maybe the core code can gain a function call to return a pointer to
that XA or something..

Jason
