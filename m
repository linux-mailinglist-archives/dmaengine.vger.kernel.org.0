Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15702716A70
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjE3RIk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3RIj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 13:08:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68236A3;
        Tue, 30 May 2023 10:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx5kHwLXiQo0WSVUVTLtfn6HTP8p1GEATXOUtozYcevx+U9etdhULEnekooPvMoun7mTW7QGeNDo/3PXFUKkkWyqwKq1wsXC1ejOfdZv2aDcSXXVc1SxrG1phyQ20OyTTU2KPJArPBPND0CaIwJmcWIU9qFl98F+7uDarwL2H693z3XZtDWtmNWr+EMgMvoU030dAyGzZYIYTh9A8S8p+0i1Oo92AqBtA66PeONFRyiKPB2HKbSTfcrZ3QSHOO1F0ZycQS4Q8Rr71wjlf0kA8kVHOrWzTVGUfnMfySRxL2t131qf/NQ4SMncZzXM1tiTTtaJ5k9yt8mhMV7QbZFxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnQ+otSSfLDIG5Qm67owXe7vXRLXAAgVbPNUL0lVrik=;
 b=JOhvtVQQAALdL17dEAdUHyDQ6viXW44css8z1OfpyLMO58tgqZh1itQrfRyQ+3ZeVKncSbRA/DsDxdQ5rKg9obfS3OWGJmg8wJFPetHbsY/TAHKWA/U5laVVHxwysKEKCG5yJmnE5i8iG+b1MKXrwZGkU0u1gJpVIHYHCk+qnKBjZhwsq/KRMoSLckDv17fYvXEjsHzxO07XByN3o2qGinG0a8TJZj3NBcl7fqMb7h7Ve3xzjYRu/WmwkmX+ItzrBgCOcqNAEqpy50mZOJyyR1d1Kv6m/nLwn9ENiy3XDFLM1KI7P1gQHS6a2EiVx3X7zB8Tgfyzmmi4nsL1yr4hNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnQ+otSSfLDIG5Qm67owXe7vXRLXAAgVbPNUL0lVrik=;
 b=DgwHVI6QDbnoleF3Xo+qNu2RKF2oTV5ONqM5Nmd10g+OTIwJ+au8WcFVsUhi/h4UF8391ED/moJBTnAaKNwh37Izmo+AyIF6KoocXpBdWcfdRRujk7jPc3RDvUuHfn6RgAsSYmYb9ewrzhXD3hPw5LK0nzgRPmAkwPIipMnpSSKOYcoRiVQL7RM8oiMOxbXrdKj0FHiSk4hsU9gXhCf7Z0zdL9AosGnvMFil9ogA7u6ERSUd9EYTHgCkROi7H00nHKb1aRDS94ec9a5IsLC9vuUBbfon89MxWCwMi4YLGV2pwbkrTOJXzyGkgzf0m4BbV8s4hkObLsanF9gZRaJVzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 17:08:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Tue, 30 May 2023
 17:08:36 +0000
Date:   Tue, 30 May 2023 14:08:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: Re: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Message-ID: <ZHYtkioNR2YfC18C@nvidia.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0437.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: d95cecad-4f16-4bf4-38c9-08db61308141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGMWSPrPL8LTHkleQl7CMheaZptbeIRw3CADJvIuPo03aGQK1S08NFbzrTvAzxoJS04JlLqaYTBmaEsNLa7YL6Cb0CtKe0XDCUzmliDkoNWXYOEh6I01pCUSEmUYUXJ/lI4aE9UZ3JYLX2dNRgjM4VEBBDCBuE464s6bGLVQ/jKcXCw3d0gLLKiHNrKRHzCxjkdb7QeDxsZ1OEroSdEMubbXb0ra7BKwPItcjAbkySr8SWE7s9O7pzx5WMlj/GQNluHWDhVvXj7ULiUY1K21gSB3pGjKFE7l6t5SVyE/u1FKF82Ay7O7gUzByoTMhY2TjkV5+Moh7k0SsbbvCcxgI2K3Vz7CfMVmydYbmIEYre4gFHk4D3P7SOGZdoEa+Upd4MObT4JsI0+VoChnjlI0LeMLNS7Py4Pj6U2qOlTHCeRkbLSzqPJ2ZigdBW7XYre9914BpJUeDNtV7w1Z2UDANLRmD4VySX2+PPAnpB/OWNgDQ8mElXWFAHqAIKQtuunRS/h6VARdfQFJaUwBq3SCv/RRKc7lYFqbiXse0ltDMAeJ8NXZUFEx2ClFckUXyuEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(86362001)(36756003)(478600001)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(6916009)(6486002)(8936002)(8676002)(5660300002)(41300700001)(7416002)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29OcSqrffcCtpINESYyUeWZL9pkQZa/vb60L2ypZ6a7BtW2YU+tfCjr6438v?=
 =?us-ascii?Q?1Mqbi6BmZJ+HuWgF9JjFowZ0p6O9+PKSP4EEdysMDjuzbKNx/Ce8jQ+BGLjq?=
 =?us-ascii?Q?Bu1m4oROXb6TSo/YwSGgSjuEjVk5t5WVpCehIprHXya9SBo/PRytxxJgqtdG?=
 =?us-ascii?Q?NaqtGad+X1KO2hAC5Kr1l+YAXnr/UotawaW38pGO8Nh6rWK7AWOR6mDuGbgz?=
 =?us-ascii?Q?sGSCEz5TZFTcWBOUeEPnwr0UfRsB9BYThIQu/d/CuPhnTD0dcCn5JUEZ01Vt?=
 =?us-ascii?Q?Ho1mND144F2VY5qq9Q1HF5dAKFXg3wkADtr6TcJTxUajQ5lXUAfwvp91Qoah?=
 =?us-ascii?Q?Db3NmDWkO4pTaRcF68YFVNsjZjyLloeXygs+8b9pwscLnCY5UQRMgTVhvrp8?=
 =?us-ascii?Q?pYIKukYWe4Gx6jHXKeilLqNTNHZIfykgEWwyokH0QpfPch2yZvs0mh7Re0ro?=
 =?us-ascii?Q?N704BMjt3ETo+5uQFqMtV5+a9TFwIrDw3i5L9x714RBDhlYh5Jx/zwXM8rkD?=
 =?us-ascii?Q?jpf7JZGnVQbBeluNLTADLY/oAmJFjnZwr2o5gdjAxIbreN2ZJLMEcHdf98Bs?=
 =?us-ascii?Q?W8F2NeOZnyyCFMpa9s3BZYXyrWjHVCW3slDM7n5ldo0SS44TjCK9Bua0CRKs?=
 =?us-ascii?Q?xT437M7vi/PuLF2b7EKIXDUt/txatZY3G6nCDk4UDNqWEpPVLNkeWU1lLNNE?=
 =?us-ascii?Q?dQ18U9CEywgD/1WaDPzKGFHwGelC42vCHt0Q62/WlELjloLB4WsI/Zyttx/L?=
 =?us-ascii?Q?Ebovbxck7EZe4vHKhb2/Bdh93gGZ5Qmc05sNW/bCdaTQfu/DWK9pBKBYcRU7?=
 =?us-ascii?Q?O5U1DccFCFMWOMyuYZ+FM8BBYTX+rEPjNjEy7D++SsBbEHcMt28e1sTCJncM?=
 =?us-ascii?Q?aFlDFg97zZlvtDHn1+e4CyHeSYXArRN6POkd6fR/1SWE9gp4cQljI4AP1VZO?=
 =?us-ascii?Q?2ppvnSPn2jmS3AuWUsHM5ZN0ZtacedlTePps78KuILhbG946NQvSsz3OpqQ7?=
 =?us-ascii?Q?VBvFhY3Xj2p0a8jQR+XtTETdkGGBY+2GqY3DCr1xK4f+fpYHAsEGmg7bIwx8?=
 =?us-ascii?Q?r6uiaCGVFNN+uR2Ew1PH6d+mcrB33nqm6fiIhFGV6t3osjTEsGms7N3d/8Zl?=
 =?us-ascii?Q?USCxXK8JeEO1vFwTzNdJhgxj5mDULsooEyyf/dwLwHgNtu2N/rQhPU5K0DH+?=
 =?us-ascii?Q?o/F7r7sQAJudRyFbqwKzVUCDLUFyDUZTqMBRdxKiCM2fRl2Jw7U9jFaey6+j?=
 =?us-ascii?Q?aSgKRGFcxlZ3te6NtsK9Vlu7BEJZKqCeB7LfdgaFum1GrCG1dNIpq5Yil+oH?=
 =?us-ascii?Q?haUerbHaYdEAcIIJhF8eCY9DABkw6L0s92Nz8cYZO5+8BQMoe8j2dLY7AGKP?=
 =?us-ascii?Q?ci+R3p/P9XqyMRciyKEXN9Irgmb07dl8gKKt7IIWm5inPZAc35TCEtCNADYP?=
 =?us-ascii?Q?364FdBIS9FF1Mn2BABA20tr7zhDu8nsvWgGIFPS8qi1OMDQUR6rHSFUl0oKP?=
 =?us-ascii?Q?8b1YnGVXbDZvSgRBj6Sew77UP8lJKAZ1d/ew3KrCqiGiq8og1NBTpcTds47U?=
 =?us-ascii?Q?ZAhxkmweCbAEoEQ9z+nKu3pHzG+eL5ddp1hpevMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95cecad-4f16-4bf4-38c9-08db61308141
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:08:35.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd6WOy694REP123c78GQdXCuNO3BMob1ae0pERCKxFpc10G8TnYNAY6JGrnv4uJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

> > +	/*
> > +	 * The SVA implementation needs to stop mm notification, drain the
> > +	 * pending page fault requests before tearing down the pasid entry.
> > +	 * The VT-d spec (section 6.2.3.1) also recommends that software
> > +	 * could use a reserved domain id for all first-only and pass-through
> > +	 * translations. Hence there's no need to call
> > domain_detach_iommu()
> > +	 * in the sva domain case.
> > +	 */
> 
> It's probably clearer to say:

Is this what is going on ??

> /*
>  * SVA domain requires special treatment before tearing down the pasid
>  * entry:
>  *   1) pasid is stored in mm instead of in dev_pasid;

Why? The mm pasid should not be used by any driver code, the PASID the
SVA is hooked to does NOT have to be the mm PASID.

>  *   2) all SVA domains share a reserved domain id per recommendation
>  *      from VT-d spec (section 6.2.3.1) so domain_detach_iommu() is
>  *      not required;

The DID should be managed and allocated for the S2 pointer and the
flushing logic should work genericly by tracking the S2's being used
and flushing their DIDs when all the S2s fall out of use. The special
identity S2 just gets a static DID that never falls out of use.

Jason
