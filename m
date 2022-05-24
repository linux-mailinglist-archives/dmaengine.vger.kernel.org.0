Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61803533002
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 20:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiEXSCq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbiEXSCq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 14:02:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5A3B039;
        Tue, 24 May 2022 11:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN94XtwLWP4m7HIcLONNIYV/Kq4X6hnqJRabS4WQO4B2fsM/mc8PdMgUCoD4cLV0Qc1vgvUyuToYVg6uPGrP904Bsy6VPtBKYAf3Y7wZgk32jdjtC2UqZnm++koiJzWNrS33CfQcoyQJstyGnzPyO6GR8EJq1SBLUGqoLpQkuh5ZYFQh17A8Q9mFcDqCMMIiegNpVBckGfFiLDxtViZAP+R3fj+yjgpWHDRJee+AKxyTkH02/T1fpeiZeC/zKWc7NcUBfmoekCKtxZCIVnr5zahB2xXYlJ5GypRMun/xcKL2NPk4JtCDOrHhl3Mmi5sdt9cxAsW7jCHb53qYxWchvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPWO0AraG7M5UGaB5JVRaj+jQeIu7ABW2OGoxixkKOQ=;
 b=XuE+H1WL0VZJI7F8ZanHs9N90ap+g3+FVrvPRHjXPD914nECj3rdtlq+wJiffXGeDLGOHQIttfOEbHAkIVIPSWhp2ctXGkH4Yt20o0Dz2Mvel3DnmSbyTKMKonnQw7nxb7k8YRaGo7L03w6qtIuLoxhSsj1hrJzR/4piUIQY66P0PJtvZaP2xyVtfQVmkkbs5mMFFGxcvGyje0a36cFq0BWw1i+dZcc4RpVFtg6ts0KTT4vM5oeudLObeFkoMtQ9t4A4Edl6HX9kZi3rk41dC5jhjAmm+zcZKJplRyYx34+6nGrzFZbn2bJ7KtbiFOriZyQzwm1qOkvL+2TOKo7o4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPWO0AraG7M5UGaB5JVRaj+jQeIu7ABW2OGoxixkKOQ=;
 b=r78D9spiC8+moMiKDkjWgCOwlMcsonHr9A5CiLcosBbiMa9KT8v5EFuX3mqowVxsT+86rZFEYviRflMc796msyt1aIA+XC0AqDWqITtxSUzbmBfOLyN7iRRRvCm53DAsJjqkWF47AEdcC9tRam3Ys+AWpJxHQSGDFWRdtc7FNkeI35irJXn5GOYi4IZdDbBd2Trx2cFdIhKpmRFRr/4q/UjGLphhjL1s5RNI7ePySWiqiSfXuX6YfPw3qcuHNLMV03DUBnniwFmbfl5OV3+pRCcs/r40cSgTpelmBMbfKVbnP6EOX/VgtDg5zuM686Gzidqid0mZR/b3uqoSXV01xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Tue, 24 May 2022 18:02:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:02:43 +0000
Date:   Tue, 24 May 2022 15:02:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524180241.GY1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
 <20220524135135.GV1343366@nvidia.com>
 <20220524091235.6dddfab4@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524091235.6dddfab4@jacob-builder>
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c978362-87bd-49e4-9d6f-08da3daf99aa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB162581DE55CC67815EEAF0DAC2D79@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvSUve95hS9yYfsFGnbUOO6tCkJWiDpcpBNakN6Vdayn5UNA1ffj8nbaO3YR92neVcMqBCQTiKWpocha/3Zf8LbvV1FS7j0Qd22wPbIlp1W9l/H3xeHVpFu3l0nTLX8KZYI9yNtH+RmWOCbP8tGxsVEbFVnmJ1IMnwW5yyuhpn7QC1nScSnDKT6Gql0r5m3l+xECUGpbJNUKC4Peg5hcgc6RBeCeZiu5LPL7fCSw+/6c7yMlx0F89g1TZA4D+xTkNulzm6pLBwRku6D4OzdayCgvNsjnrWExAnK6PrwLopTNC/sPQ9Qp3+vDsEZYHTNUtW0UdS6rtoRCOdOyPsDGTi3/7ZILzzzYA5hwnRSq+68SOAQpn14OfC1ufy+YevJwDVvubjugjHYSFCqAGSKY1SfuGawxj9u+7OurlLM3AQ/+ZD8PoQEKgsv9Kgb35TZzkBSsJrI/SSfrI3pX1MFdPY8njK2PmrI5Bphbmwe3L8fX4Vx1sACA3XH11Kgx/wYZGhjakAswGj1WL5LUf5YAqfCp44yfF2nvC1PBushvzLE7cPAWYDRPZB8f+9/DuageejcxfI6h/3FHqz0HiQu56einiSQjcs4oyWsR32a7lqQtvwyQITT8XV9z8b9a8GN/dWBfpbYYXXdg2OZfFZxRFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(86362001)(2616005)(1076003)(6506007)(6512007)(186003)(6486002)(54906003)(6916009)(33656002)(66946007)(4326008)(316002)(83380400001)(36756003)(5660300002)(8676002)(66476007)(66556008)(8936002)(508600001)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?maOZb9VBbSqVnNcHwYmSavRbdbd7SIJIxki2fZytiwtYZnru6xcqDLc9Z8xp?=
 =?us-ascii?Q?xcz+NyhQP773ncs88yzj04Dmw34koQyneG782Fi587GpHdDE270+RODIGR8R?=
 =?us-ascii?Q?CR+ndkpeIEPDN+s+10ZcJ/MBe1sFQLOAJloKSrlO2Lc5dPcfcaUTK28esPxK?=
 =?us-ascii?Q?3kAVPzb48D1/ql1fN4F0l8HZrzuulI6EmoaIX0pJzvUY0GVEyH/v6o190UWy?=
 =?us-ascii?Q?3PMA6qQK3Zufm5o8b4mVYEOgezNqM1KPl4pNN6Ax3jDgvSqBuXE5Qe57fv0e?=
 =?us-ascii?Q?aLv0dHTx7ie/l5mOps75LiZ0mmJX5FtgsQUy+fzCeOF7sMGNUCSkaJEaaECd?=
 =?us-ascii?Q?c4pnpQUehQLN2PeTOy6s5/wxsIuj3DkyA1jmrqcvRcbo9YQfupI9ryW56eLW?=
 =?us-ascii?Q?vQwqWH0XeBObMfZyxXG5CywgBRLQBtDHeZeDX4A0uxW+Dg8o7Hk/Mi/aQ00J?=
 =?us-ascii?Q?0K/F0YzBpVspk2ZoUBCyZFfNDw0xbxoBES9fLXpNdiOlbzSuI8mADvLJOOvo?=
 =?us-ascii?Q?n60x7It3u7yezH9Za3avzC/kg/stw/0r3LsczjHny4qTPuM1ZeCIWXawv5AO?=
 =?us-ascii?Q?iXK0VfI8a7pDhLp76xH6Re8XhKiR2vh5wJHbg35+X8ZD3BRJdeDIEIn6STzq?=
 =?us-ascii?Q?mu0zFsCnQk4jAedFezKKxU+Ly1yt1zSZ+oHSUwaDV5J+UKCa/yT/ntSLg18J?=
 =?us-ascii?Q?NBnEIFcnMV+wUM/SmOAPBelYEHzRgWDBeW17TYVkwAjxYLWJ3EnJ/G7G4CpL?=
 =?us-ascii?Q?vVU1zXXT9OhC5dea+6tQejIsJ9vp7AcLCO93uAltLOB5LnGtqO+yameN+grW?=
 =?us-ascii?Q?nNkhNDA9lctdbalC56ZKieYjYqIA1F9OLj4uBZLmcthmTTQnfGeAYBVBpaVh?=
 =?us-ascii?Q?OJWMQoZiu/urMogKlpBsinPC7rqQM9Svs1/9cV8/ZRlqba42aeqxPJe4FEYT?=
 =?us-ascii?Q?+Nn0MnjhNBWSgMnQ5vQrJpJQDGoU89QhGMtxXx0EQiQhCKzeDsBM+WViTZZB?=
 =?us-ascii?Q?VXBCZBynt5gOs3Y0Y5pcvIdy6aQAppqx8YGWS61LuCem713qBXWcyVmu5eia?=
 =?us-ascii?Q?xhP+ASyQsbvptiEHVrqOYyFhz7UbGaTGmAZ6/wrj1w46x+vJZYXHrxzsnpXK?=
 =?us-ascii?Q?cT4GBXOogWNcYpYwl+PwLBJkyalLTHhoMO4Zg81zdCxzqEHWBaj20l5mPRij?=
 =?us-ascii?Q?olNP+7R91wuj/vUZ1H3rdyNnGwt8XXqHZyUEp52HPJfM1lC8rTP9x6CZalaW?=
 =?us-ascii?Q?auQ24UkFswn8MCeN5sH0IQmJ3eCDpVWW3Yy7y4O++OFnN1rPJMfZCJq/q8Ju?=
 =?us-ascii?Q?pqA2/HrP4L4Ta+anFhS6AJktIMLHk8JauFYeIKZ3v9xMVmnx4TCX4D/6dN6W?=
 =?us-ascii?Q?q+ypeC6fX/6weMlzlqA37q3DoJPmNIuLgvB5Lnx43t3JINNmxdo7KQo+Au5a?=
 =?us-ascii?Q?zGW8fjcmcuQOoWkY7wDYfshc6Og9M8lLidQMSigXgXomhSyignIg1/uwoEwh?=
 =?us-ascii?Q?WyB3Si4WSQEBAU3eY6VWYhnfX+cpS1R9kjmR6a/Rq4MzogWorWncXWVNGV+H?=
 =?us-ascii?Q?/i1oaAbKfN9iGXn6kSyRJUdxUpuJFBSKuVf+7B43rWfQbg4GLL9RfjMOysPW?=
 =?us-ascii?Q?Rm4I+/le9+jYbeNMTfFK6rSyB2HBZkP0KNnJfh6fzFsGKCSAL4U2zs49VLj/?=
 =?us-ascii?Q?IIrTG8JIvllvz+lB+zRW+GtQTXOiiKXlLW4CoH8auwh00WY9SwSpZLmP4e0w?=
 =?us-ascii?Q?lZqFTySFJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c978362-87bd-49e4-9d6f-08da3daf99aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:02:43.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uN/VbHFAldUCVOq8h2SEMhkEIPP8KPzlyN0uAl/k+Payl2gpPfCZXwuDv4OHUFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 24, 2022 at 09:12:35AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 24 May 2022 10:51:35 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:
> > > On VT-d platforms with scalable mode enabled, devices issue DMA requests
> > > with PASID need to attach PASIDs to given IOMMU domains. The attach
> > > operation involves the following:
> > > - Programming the PASID into the device's PASID table
> > > - Tracking device domain and the PASID relationship
> > > - Managing IOTLB and device TLB invalidations
> > > 
> > > This patch add attach_dev_pasid functions to the default domain ops
> > > which is used by DMA and identity domain types. It could be extended to
> > > support other domain types whenever necessary.
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >  drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 70 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 1c2c92b657c7..75615c105fdf 100644
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct
> > > device_domain_info *info, u64 addr, unsigned int mask)
> > >  {
> > >  	u16 sid, qdep;
> > > +	ioasid_t pasid;
> > >  
> > >  	if (!info || !info->ats_enabled)
> > >  		return;
> > >  
> > >  	sid = info->bus << 8 | info->devfn;
> > >  	qdep = info->ats_qdep;
> > > +	pasid = iommu_get_pasid_from_domain(info->dev,
> > > &info->domain->domain);  
> > 
> > No, a simgple domain can be attached to multiple pasids, all need to
> > be flushed.
> > 
> Here is device TLB flush, why would I want to flush PASIDs other than my
> own device attached?

Again, a domain can be attached to multiple PASID's *on the same
device*

The idea that there is only one PASID per domain per device is not
right.

Jason
