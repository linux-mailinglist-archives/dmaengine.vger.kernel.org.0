Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA64716A20
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjE3Qz2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjE3Qz1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 12:55:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209339D;
        Tue, 30 May 2023 09:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TObN0pPeUj34oixgr2qmtABrx0+PHoa00pyT6BVmthXcHnAJ10yP//bS6w6eMz2WmnsmFnPd6HJ3488abvkXS16oa5lZD44/QoqGoWQzKsMtpgPfxJY26pq7Q4RrY1J8+4J/4FnUHahdUnlLYAV9ODgEYxrjNdGn+EAsBYpEtOV7Vgmd43XlX3vpr++LIqC7VUr5wakU1COuiu2YY5FDDb+Ac4IQXP8PB9xBAxl6VU5yW0s3i674YvwGG2Dl3plNUb79lxnyTHSy4cQdmyAo8Bcpnuqx2jpgdBdTu3CDemGEFfEdL1XpX5e52Ff1cUpxndVQAmlRhxSazYV0O8vyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DywuabSfePjJfJPzHwAASdYCt+qTvIowPs904Hqf+CM=;
 b=R0BzQno9BXHHpN77f0fTwBkTSTHIhjo1rhJQaHEXB+rz1aSK8Ze8syVaEvGr8q/eqQTA6F63vpkNLEcg382MHtkG+B14cNoBk+k33s8mYAohw3Q8z/vAH3QnTMoEF9ynH2Pk6xvxZKdjKxdzuRPgOc7e60hjZKsHXX2M88cYYLcKswfdS2QNKa2P1kyVpfRcapB7mvsVXh9e+koAcxjzC+qwRwKx27KroYN5vN9FOuNFLj6T8gKgAKA73ICnQtg7jJSmSLopBfqf/aXHJjPEdWMRpeTrmHVRWZ0frCQzq77Nd1jF/5F1Zm5ARCmMtsOB+6QE076g623fGJJQvrA7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DywuabSfePjJfJPzHwAASdYCt+qTvIowPs904Hqf+CM=;
 b=RsFWOUbKDKvzVFvW/9rnrBgYxtY+YJd1Tu1UB+rBdvOfoi/+XhljWMbaqbArd3065lWfeR+Pf9t+Eutttq+hsQhpa0AFVFox9wA4UxmXGbM7LBkETcRbioIRZYUszxymJog6CDjZJUWbRgfnlqup7QLolZ9wLj44QRFyAMsoSzOQv1saGsipoV8Dp7hYp3c6wwM9ZHQBZMudbHCjtEFTBPyOg4ixPK+ZjbzslU/ciCWVeJ0WmPLMA1BLq6/kwTJGrya5P33JNppXDwryUCEXWXoUk9usKZllHB2wK4hsehB++MwbKS0AU3oDq06YfReLQc/Po/O1uNugoPA0MgeS2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 16:55:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Tue, 30 May 2023
 16:55:23 +0000
Date:   Tue, 30 May 2023 13:55:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Message-ID: <ZHYqebpMC12ck6gQ@nvidia.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-4-jacob.jun.pan@linux.intel.com>
 <ZHUBoBev2Vzp8nGF@nvidia.com>
 <ba26db48-4102-d6bc-add8-5449423158ca@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba26db48-4102-d6bc-add8-5449423158ca@linux.intel.com>
X-ClientProxiedBy: CH2PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:610:54::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 520ecae1-1f98-4757-42e9-08db612ea8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLd9BLtEJPyw/H4lE/h/D3ad2+EHeoAiVaHa87qsyJVdAASFYxcDU86r/yxEM0pINRqJj4ZNi30F7TPqLRQFH70+sOayiTZV+IbU666Yzo0w9ZVEIwVv66Xo7WxuIX6gs6+s8dU/LsKNMQXc+N+cBrPd4jVLnRTUwzA4VMxzUteUMSx13AREJvq+4fHFflXFNhiDIdoIT2bTzLJbUd+epnQiKk4V2nkpUMuaQrhQNXx9MlDJOm4hUfMsBSHWtmG1Jb2kwVUSR3ZLPaJpTszrL8XQxTSA8RKlE6v4Gcii+TRbs7Qd5rmHsmi3+MEkIGI6BhnsF5CvUtG+VFnSaPzvQEJZHeUdZCVe7wR91dX//S2gW3si06NIQztiD8vAy1LYs7Y7lvnpqlMT1w9bMYwwNMxrYApnsKVMSE7/WFd0IKilBmK0c59FU0WkxyQg/Tcei+9yzYAzhLl2rO5eAab0AFNCOEB7loety6jsT+3/3KC/EmhpmPWO2CK23RZIQmksazHng1llm0fcdAd6QhF55s+L7ErV1pOL9RcEs0uSRdUEvP/E2zBVSC/YhjgJ6Le1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(86362001)(36756003)(316002)(54906003)(4326008)(6916009)(66556008)(66946007)(66476007)(478600001)(6486002)(83380400001)(5660300002)(8936002)(8676002)(41300700001)(2906002)(7416002)(38100700002)(2616005)(53546011)(6512007)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EX/RtAqi4hyxEa5te8pQg08T0jqgqz/UuHhMbSvK9EoRqYhl/X8YwKqr9APA?=
 =?us-ascii?Q?YePAEHzyew/bBfbGDYtQub8TRLuFPf7LVWDOjjvDslGnNfpe6DZLHSPvso+N?=
 =?us-ascii?Q?GCPcqTluZA7bNTDmOWvB/v/ZRTwxJUcTrsaZ9NWI6adeOBxyEN/xCYxEixpG?=
 =?us-ascii?Q?OWCouIeaI3BdluB7rVIx3SifTKAU0hdoXhW6JVZbUR7SV3n2KXIz8c4uuHN5?=
 =?us-ascii?Q?tDoj+o05HiVa0kH9HARILYoauq3t/ISw48EX9XG9lkZtpsZxdAjrGnXcdrz6?=
 =?us-ascii?Q?t3njTsHaRD93YrvQ/ogSZNbTTzo/vOc51HzNUd00+R+bLJ3kWWtGnDwgk0NN?=
 =?us-ascii?Q?7vx73CLP+u4DX6GhO6CTjuKEkqBrKK2bZ3ZpGDiyi05KEZPpFD8lGQc/FNqM?=
 =?us-ascii?Q?jexcqK1Qk9DMrAQF+sZneavsL2QmTAXS+OdG0uN6AYgr+G9YSI/2yo4/CFwO?=
 =?us-ascii?Q?H5fpH/uJjXLHWH0q7fckx9xVNwQgDt2nrgh665Sn8/bPev9gTEL+5ubTw0vu?=
 =?us-ascii?Q?eW9AVp4xixUKiBm94bGC+Drd1JeOHfPo8ix+18ieFpeRO7ioLJcYsdOfGuqg?=
 =?us-ascii?Q?136+8XTXNVnxG/gcFBK1stpf7lSaP7nvx/cv+hjivBVLcrDtcKWV0iNANzyW?=
 =?us-ascii?Q?uJLloy1zM0hUDxY4RHnTqDUxNAr+RkpdFD4SzsYSfuDtM+6h97EBQhJg7chK?=
 =?us-ascii?Q?disl1l3q4qqSqqRkMriSePmBoSzG7yv9B3q3eAKbWnQzUDcLML4VlOdlu+pc?=
 =?us-ascii?Q?VTA73Es4NIgbo78e8fEUPdiULjZyAplBuX8tegWn6L8LhwXbWTpXmumBs9p0?=
 =?us-ascii?Q?CHtqvBM6tf3ZME5qBKxZsHwQEbiF3/quk6O82czglEJqJEH/j5J8FF5i4bbO?=
 =?us-ascii?Q?HvbeWVA6zM0kyCmYRoRccH7k7k4E81e2AxlHWgWVb+OoyCsFjWdKk++56+Z0?=
 =?us-ascii?Q?X+ParhCPcQXVjIMaSFIL93voJjeWDg3xqkp+FbPUVDnSsp4i1iDuLTlqn+JQ?=
 =?us-ascii?Q?HO0mCnHYN0IR2AiqjFT324Gb0Kx7GaP5cBmoJZbi7zc8rqhXKj1pwLLq+6lp?=
 =?us-ascii?Q?UDn7NXE1/1ZbwyF6jW3QdmQK7B+ArSXj++j7+R7qe89IQ6Kwte8TMtolaOVO?=
 =?us-ascii?Q?k6TvXXAqLnervsPc3M0pQF2kitvgTNzi3Vs8sPmjpYCj7UHqm8EMxBBJeUFp?=
 =?us-ascii?Q?aMNnJNEaGgdAl0uun/QaSL4lVR1df0eVPLamofh8QL8vS/a5Yt75aIPVm8Oz?=
 =?us-ascii?Q?3cH7/xpaLQoPaZEl4XQVuJPpuF613LMOMGZ/brF4zY8NTn5jliAYh3HoHen/?=
 =?us-ascii?Q?AqxFLmRdaW3v9JT145Uk3UTWP6fk++V6Q8HWQZ9CigcmJ6UUx2XVVRTszmIl?=
 =?us-ascii?Q?xiJbIABMt/Xk82nQCwZvp6Jh0H5KJMhB3sbi4evH9pBmVytm6kFGaWb04/+w?=
 =?us-ascii?Q?pvc4i9gm8/9IlMC3B6mbMuW3mOekCzgeNx1UPLJ25H/BH/mTAyZGXcBp/nDx?=
 =?us-ascii?Q?nTbSrjnPNeVmGH0gvWirkl6d3tPt1TP2uka1GhYgVJhJNNmMI3deqhGJBeNo?=
 =?us-ascii?Q?vZ8rFjqYDY6s0wcmWPabuu141jeue1H0x7uKqm/s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520ecae1-1f98-4757-42e9-08db612ea8cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:55:23.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwl3Jo6malbkdWVTQykPScbu6zD63TAR0SIipoMxsaghBay9zJ0UZcc2Q9p58IzB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 30, 2023 at 10:19:05AM +0800, Baolu Lu wrote:
> On 5/30/23 3:48 AM, Jason Gunthorpe wrote:
> > On Fri, May 19, 2023 at 01:32:22PM -0700, Jacob Pan wrote:
> > 
> > > @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
> > >   static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> > >   {
> > >   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> > > +	struct dev_pasid_info *curr, *dev_pasid = NULL;
> > > +	struct dmar_domain *dmar_domain;
> > >   	struct iommu_domain *domain;
> > > +	unsigned long flags;
> > > -	/* Domain type specific cleanup: */
> > >   	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> > > -	if (domain) {
> > > -		switch (domain->type) {
> > > -		case IOMMU_DOMAIN_SVA:
> > > -			intel_svm_remove_dev_pasid(dev, pasid);
> > > -			break;
> > > -		default:
> > > -			/* should never reach here */
> > > -			WARN_ON(1);
> > > +	if (!domain)
> > > +		goto out_tear_down;
> > > +
> > > +	/*
> > > +	 * The SVA implementation needs to stop mm notification, drain the
> > > +	 * pending page fault requests before tearing down the pasid entry.
> > > +	 * The VT-d spec (section 6.2.3.1) also recommends that software
> > > +	 * could use a reserved domain id for all first-only and pass-through
> > > +	 * translations. Hence there's no need to call domain_detach_iommu()
> > > +	 * in the sva domain case.
> > > +	 */
> > > +	if (domain->type == IOMMU_DOMAIN_SVA) {
> > > +		intel_svm_remove_dev_pasid(dev, pasid);
> > > +		goto out_tear_down;
> > > +	}
> > 
> > But why don't you need to do all the other
> > intel_pasid_tear_down_entry(), intel_svm_drain_prq() (which is
> > misnamed) and other stuff from intel_svm_remove_dev_pasid() ?
> 
> Perhaps,
> 
> 	if (domain->type == IOMMU_DOMAIN_SVA) {
> 		intel_svm_remove_dev_pasid(dev, pasid);
> 		return;
> 	}
> 
> ?

I would expect only stuff directly connected to SVM be in the SVM
function.

De-initalizing PRI and any other pasid destruction should be in this
function.

> > There still seems to be waaay too much "SVM" in the PASID code.
> 
> This segment of code is destined to be temporary. From a long-term
> perspective, I hope to move SVA specific staffs such as mm notification,
> prq draining, etc. to the iommu core. They are generic rather than Intel
> iommu specific.

Yes, sort of, but.. That is just the mmu notifier bits

All the PRI/PASID teardown needs to be unlinked from SVM

> > It would be nice if the different domain types had their own ops..
> 
> Good suggestion!
> 
> We can add a domain ops in the Intel domain structure which is
> responsible for how to install an Intel iommu domain onto the VT-d
> hardware.

We should have seperate iommu_domain_ops at least, I think that would
cover alot of it?

Jason
