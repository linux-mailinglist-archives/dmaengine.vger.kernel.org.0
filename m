Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD066B10F6
	for <lists+dmaengine@lfdr.de>; Wed,  8 Mar 2023 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCHSX6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCHSXy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 13:23:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A535D8B8;
        Wed,  8 Mar 2023 10:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGPAMDxOrYSqMxjIJRnSIma/FkvAFRtxaHB4Dcr5PHM4SCiT0PPcoFWloGFmmo+QS5Jcjq4sXVsuMNpMjqd93B3y3GfLLFl6GvW68TUFZTAUV6FXGRLolo77cM8NTDEOdxlB621CcJFmFMxV+OtGwuvgxc6YnHzadgoFHyXQtAFiuX3/MCFlx1gRR4mzBg/+pwvwnd4fNQckjbrMNPCsloSKZrpm3tpPeGkvh8NZSlm8P6QOmwcmL3NS/Cd2r3rCPjejHlntxENmwcytuhTX1Q9Ww41qJTrFvKnW9B/+wrgSfiavoL6g2ve2bgm+2iPbE4MDVi3u+ybydZtN1+0RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb+RifHl0F72hSf+3BXDc8FjdeUZQzowjKg3X1BGCsQ=;
 b=OrPqLIlVvobkN372GG9zWFRf54vijxj2fbp1mVC0Ep80G76Qb78lUzt1nB5446rqjSJisl3Gg9sPRBG2uJilqTCHCIsapaNhY+jBaQQ743kEHH9GPIzs7P3EyrzqXSTlHCpv5NkcrOwjQsYi7jRDOoW0w03ZPjWvMFqJvLC1cF9N4WRcprrBW5Xlbx1l7ofzj44j2HFj6d2YrvGETUh8ASTgzhwaevcrUJSNxlClS7jY5Bh5wIqPDY0wOEtDLGAgBHcDJ3PtFCZoJO3Zsm7SAAfISCvRgTZdn3WWUvwLDCWTgBYuUX430/tFVEYQKqAa6BNXgpRkZK+BEnlYobvfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb+RifHl0F72hSf+3BXDc8FjdeUZQzowjKg3X1BGCsQ=;
 b=kl0bRVZiCcSXHngHRcer8u9dSRc/cVRgFLlzK50iBhBj9M953ye5AJPLloHR/fVkHih450W49uK9lElfKhu35b6w+deRwLMp3BknYQmKWUdFd91s22yzMAI5rpgJ9HYnlxwmfz6IFx5SpG1Uwvy/TEeLZeZn0erJLHeHk23mRr94e1JpnLACXErnjymjttg4KpCp5IytvTDw/NkOjOobdBVx09I+GtXUqCzaq6HPLBJ9St7cCNMDLmxfXohEK2TY3ta84Y1C2Qip4ABjqrlrYxKYHoksnLh0YX1mGO0jhgMlxrFcjXIZdhEJmFCDFIj/vFLNu+5AM7BTvACRx3ffbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 18:23:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 18:23:49 +0000
Date:   Wed, 8 Mar 2023 14:23:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <ZAjSsm4/PDRqViwa@nvidia.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
 <20230303093235.GB361458@myrica>
 <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
 <ZAHzAa0mnilf0N9K@nvidia.com>
 <20230307143209.2873d9e2@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307143209.2873d9e2@jacob-builder>
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f47289-f38c-4eb3-3879-08db20024332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKY88GnVt7KYDLFd1pCnO6tye7B67nOQFvDo25Rfc32xHSrjIcwciMl+xDSYEX2ks/dcZsun34U5KBk59iGjTxLkM5ZdE41rWJ9gmZRnk0lFK+78hktifvzZmjUSRPeYjQk7JI6bXokuuGP4ZIkRxIFI7oxWZWuhCNKA8pcYt1himrOAOSvFi+pga5qGuYO6ykZ2vhM+k8U5ZeBDod8tz0vW8MnEFIMqrai7Q1HVn/Fr1JIJpBiVu2VBXwHc7DfNrAPcEUeptlv7oxmQncSB/NYJvGuzxTjpp3zM4Tgn5UPSWIy3EgR3sZEZGg2PlzFYf4NhVAgAr33DjrYvKcCmUItWjWksVQi0aqcwA5ksItZpke2rKbQDyfk+gj66oM3WruklHOtpyK2H8iiVJuqBzab7TfRAfEEIsBoFFP7xkkr5y6W3Zh246HafgXc/r7V95jvnQuGCDZs4hrKueD67m5Pwnwi05UcgUk9dFS57qvmdPE/55XZeNL16QGnvglKgQsuAXyJoomkdLeSU8+cic2YYNlLxHiieXvm3R3hwDX3AkdywV0dCjL/tBuYSVOSp6FVk3wD+Mj1m9je1sSbBVXoQ99xgrq5247H2pxpUyRYJTDqo6U18n6zqCnWjeyON83ePzqe9YRsxKhsXipDhVTQsoJz5/TtRgwd0UwVUqL2yXIAzCmtLnlVVpGKBFDAE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(6916009)(66946007)(4326008)(66556008)(41300700001)(8676002)(38100700002)(5660300002)(66476007)(316002)(8936002)(54906003)(7416002)(478600001)(2906002)(6512007)(6486002)(966005)(36756003)(53546011)(26005)(186003)(6666004)(6506007)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipyMf6f3CY6RZhmPZp2tj51At/4Kj9U33nwDluClPkX8bGS27Zoh+EXUNJRt?=
 =?us-ascii?Q?+8vLTKe2nKRoBp+b2/ApBqSIl1QP49R0fRGliXxuDJreg29SnURtCsHSVuTJ?=
 =?us-ascii?Q?zS/B/YNo+i4hJokJKxe8fUVVS6/T1X2uvJKu7kcXeU1j4N846yGmOTHLvo7i?=
 =?us-ascii?Q?EFt6ZtTF3deCGT/bIgJ/vV3aO0SCuaSjhWzAFgRiIc4ca/sCKBj4sAXMjlUv?=
 =?us-ascii?Q?IeeL6MlefuRdnNC6LzZtOprLURUFwczTXH4whRQhlJTBch9YKIcXgPf7s+BV?=
 =?us-ascii?Q?fxE3kVZZaIg6++LwaBNal1u9MdalKJuPQ8Bof97eWPhw/g+piK2Hk0dd4ldl?=
 =?us-ascii?Q?J6V4siWgv3+WzFHY08Li0UK9pX9E0A7qW+BkdhjcVwaHELsjD0h6rHvISai0?=
 =?us-ascii?Q?KDqW0G5Y//c5NBKIuBPxsUVY7qT/aqCbDaYRiayYfTsvNUlsio0O7xXGrd5D?=
 =?us-ascii?Q?MeAAWHgkZT4/MRg0oU5qst/4vpUr3f7S5Hq21rwJ87x1nhGLY2sUEzb2GT1E?=
 =?us-ascii?Q?qvYC/7s9xp6v7hgXRPlamf+yTHXOCOnI2gYVph8q61ZEvR32NGTNC7iBqf0w?=
 =?us-ascii?Q?1NjCibhM3pFkche1771kQAbuV2EvzfDG9JgKsZWtRfTjNAZGTMoKgXfvpKdN?=
 =?us-ascii?Q?TYse9ypbTLc17EhtYm30nSN45mTV4CPSWmfKl+alDispdxb563oq4OZGQOYQ?=
 =?us-ascii?Q?eSRfIFbMsLbUCPVTQEZrhP0K5pcAFqPdp7VmxJGqRfwIxW4Q8aJss7j+1L0r?=
 =?us-ascii?Q?iFX/LtgCNX0Fjtz+Y87WSS4wm7jqf9XecmkmTXJYCLDd3ZVqKUydZ+kMjbHE?=
 =?us-ascii?Q?+woNnfiKIl97Qhmmnk/3wXK+pJudfMcoFv0rsG9SrivS7PDGCCzrZz1aUJqy?=
 =?us-ascii?Q?6C3+L8Jdq+YHAlmGUvWJV5lcjBl61WABRzp5dx1An/bsaCVt/kDhVTvy6gOS?=
 =?us-ascii?Q?Ip2Si0mkacdDqbDee3A0kSHc2esxVilxRG6sYtPH4iJqO4AjicuSgbbMz/qX?=
 =?us-ascii?Q?KOWJ9uM5fNxvN/z4jbc/RNQuWLSqch+yb6spirbL82hiJ66yh67ZfgkxDu7J?=
 =?us-ascii?Q?oqu5c3ph4AQbx0v9ywAN+GqP8A4LJY3jdXvWsWxTY11S1BuTJD2wgytj0t/1?=
 =?us-ascii?Q?cUX99fFSgWkUPqebX80wMifpumkU16vfoLEKvWJXUj3MhUVl29oZjGi2Y7yF?=
 =?us-ascii?Q?8IKd+al7Xr4kQ21LeDhCzH6dLcBE6eVoMmZ2Tnt+J2PhAoT1YEo9p4IW4c7N?=
 =?us-ascii?Q?t6IWKlym8J7Uqv3zL3SsNi/mqOmglQ8A4sMDnPmPXrKhoNP70KxAhuvenG+8?=
 =?us-ascii?Q?cdiRQQI5Zi06tVNSj6CSysTPBEbTDBddW7zqLQgZzI3gdrSr5SfrLrXm408h?=
 =?us-ascii?Q?FgOYgATaPPxT5AZnr5UY63XBpEwI++DHLCSHgCUK5omBxoPxWKapPiOZGZ2b?=
 =?us-ascii?Q?eEwCrE2nZDsGEG9HH/8FOnio/8UnXK0XPBg8vAADwS/MlosaXeg16IWGgCsZ?=
 =?us-ascii?Q?SbqsQnH1jmjL6vM9JjWBvkWS15tkW8bbT6JcFVLlFuWpwaSE674rLyWkoKAD?=
 =?us-ascii?Q?EXaf/wkYAYcLSbscnqgQrcJrIdMN4hwzMAmrokv6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f47289-f38c-4eb3-3879-08db20024332
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:23:49.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bxWwcYjRhNns+7JD1qgbUl6yiEaU90d4UOfp7f4q3ZGuaN3V5qIJ7smoq5hKKMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 07, 2023 at 02:32:09PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Fri, 3 Mar 2023 09:15:45 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
> > > On 2023/3/3 17:32, Jean-Philippe Brucker wrote:  
> > > > > I suppose the common thing is reserving some kind of special
> > > > > PASIDs.  
> > > > Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could
> > > > just communicate min_pasid from the IOMMU driver the same way we do
> > > > max_pasid.
> > > > 
> > > > Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
> > > > driver calls to reserve PASID0/RID_PASID.  
> > > 
> > > Yes. We probably will use a non-zero RID_PASID in the future. An
> > > interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
> > > should work then.  
> > 
> > Just allowing the driver to store XA_ZERO_ENTRY would be fine
> > 
> It looks like there are incoming users of iommu_sva_find()
> https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/T/#m1fc97725a0e56ea269c8bdabacee447070d51846
> Should we keep the xa here instead of the global ida?

I'm not sure this should be in the iommu core, it is really gross.

I would expect IDXD to keep track of the PASID's and mms it is using
and do this kind of stuff itself.

And why is this using access_remote_vm anyhow? If you know you are in
a kthread then kthread_use_mm() is probably better anyhow.

In any event we don't need a iommu_sva_find() function to wrapper
xa_load for another function inside the same .c file.

Jason
