Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1466AC025
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCFNCR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 08:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCFNCF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 08:02:05 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C822D144;
        Mon,  6 Mar 2023 05:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK/rCNtUaXHezL7oDn3zqLOHEOA2F0NSXvt9MGs7t8oerHA89dujVzcuDdAMbxVTtw9/nKsEsLlTByDXcwG7fbvlgUXNFW2Gm5Xh6KXDnV2bRCj1X43J4r+JJVLqE5ms1inYgYjMswLV4Qi7mvpGH8p8Z1Fn1E84UZyc7lNpzJu/gb7G+hVNBOqRxzn3JKiSA5B60x3YcNWeH40+PsduP8h+s5wtoNiYutRFaKeSd9pT4WqlCWqp3AVBzec+2lsZhXzF3dPlGiJPFTP0zgkezB3QUl3JPNHi6KgWJqfP4wrS52iWd3NPeZkhEef30yHfS5OeQuf2Xl5bAxBCrswiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VqiEfePhkudBHP9ikC+lkqurr+MkjxxI1YsEA35M8c=;
 b=YECFhfTcLCXyLVmVhrASUw4LNdXHkclywD+g7q8Nhz0p6VpYRMiT+dx1/VFBrWr6S03m/LFexsZMqboxIWZfqZK4KIC+m1Ft+tcLgfnJCzXJwxeaV/T4cwBmBOkDyJ6u8Kra6gLhkbr1rdgbvfGySmWmjFiC6uGC4v/09QfanuTtSmXaFFuuGLQKOwnRTToCXdIGLje53HPtNxEEXbC0j4MQZcgLAcf/EjhICIDmQ2/X9CCjUWmAlX6R3o+8pDa2ieCMYC4wVLOdA8y3nSpGU4HlJRipdmJoN7zXLP3bvk4WvR2Tt6WtM9GDblyNHmpU8ofJV2lG9pmKOIpQcYicng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VqiEfePhkudBHP9ikC+lkqurr+MkjxxI1YsEA35M8c=;
 b=BstxPgZMk13Ah0zRfcaukKI3EBj6mgbrooXeU9+0bM5PNkXJqm4M+EPYtrASIXImKnoHimT2PNslDqSci+1tObokfq0Tmcb55FXw2F0sCp4Q19if0c2CRhcYPNitk96WR+C81Brjxaf+YXJeGOUeyyphOfshfJkrXm4P2ybYhSQMH7N7qwvhnmsd6lg7hHGCV4JWU/lxEBWxxD/IyqX9wBZApgDtXwoju6XSLGDqmK8ooFFihAI/Mn5Ur+wjmjvCM66XvIRTlE18azsrmveG6QLIpY2aGeQf0v4mGTfXATphBfMc/NGuo/mxaOuQWNgH/6cAjxyHdwcMo3hXqoDhbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Mon, 6 Mar
 2023 13:01:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 13:01:35 +0000
Date:   Mon, 6 Mar 2023 09:01:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <ZAXkLN39VUSl+t65@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303134753.660d0755@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303134753.660d0755@jacob-builder>
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 19959cc2-23ef-4c27-c43b-08db1e42ea80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okE/KVyTKlU0gTz+vIkjbaSp6qUF/3ffO1fIMAF6snncq2mTpBJ7o0W/SvN0lLA9l3ugJp31iWP5BToB64oCJg6+1BgFC7XQFleHXR0pcfm05rjkhoEh3PjrEHk/f1N5GvDQW49AxJrGG1FYxlGKDSNtU6bt1lDBDZWg/DkkUij1ljO+ZAzZnGi55to1O4om/UftGZlGXeGnudT7fH+pE5ovrXlNq6rEphjtT83MP7fNstr7vh/8yQu7ZxurygXEzXQOw70X0JCAqqWPSIxGZZ6RCsDqUS/K9dPhM/Raq8ZJvixu1QvttEcjnWoLxeCTjQkCs0lYQM5i+Z8id8HDmbof9c5dn7xvcPe7ZV1kkn1FJFwLDokDPdx21i4ObKk90AWcYBgBUnKw+EAkoFx1OCZjZ/PaE8k+9Y270gfqHDD7lx/nBb2nFLp2FFZbBAe2Qvzun/b3y1A4m58fg6WB4XXJ10I0VdO9u2elSObloM16bEeQ810ewBctmTWIE2URyOCALQw/H+Wo9WVC6Mj49zxY8yXLbbd8jerLvFEhbtx2EG5uOQZMHuca1x76Q/DHknGz8RM9wpJ7K33gg8IeokLho4svhpc6iq5ArgQrBxJ3iWZhPtPasM6Asr7stB1XlGEQ8WhjCjBve3JmKh5VtxUoR5qjI3qRMRp0QF9YSFIepYgldV5zK2Hqh79OzAqa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(26005)(2906002)(38100700002)(2616005)(6512007)(6506007)(186003)(7416002)(6666004)(5660300002)(8936002)(316002)(6486002)(41300700001)(86362001)(66476007)(4326008)(66946007)(66556008)(8676002)(6916009)(478600001)(36756003)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJU2iEoep1yQKqybkbppbwGcLgmKbYLno5q7DST5SMJjebvX5twy+8LioS4S?=
 =?us-ascii?Q?TJoMe8eojrB56b7FX9I/P6UrOEWWCfWBy7lwKza18SxDJQ+TFSie1LTyNOor?=
 =?us-ascii?Q?PBomum4G0IhJqZSt86bOj9C4PBNBJgK60erkRCZ8bMAYwDlCWbA1Cn2es1NN?=
 =?us-ascii?Q?UFpCJP8X1DmQDm46GgFHdEy/f+s8kXKAat8Dd6AJVLDjxCf9GpPYP8Dg/iuI?=
 =?us-ascii?Q?HrWCvXfHB2lwcpfTOf3NHOpDy4cAEfQfiXGk119vb5w0oPu5wmPTDAdH5tMj?=
 =?us-ascii?Q?RWikBdhvCaY/EKw8FLBSZljuUXcTIQe1xj4aoaonkw1dja3NkwSp7hN68N00?=
 =?us-ascii?Q?InMCBb0UPW6KzPVFSFPfJK9qc7OOXYfIyz6ZQXuzhoGsPj8WmMetKnYiRSa1?=
 =?us-ascii?Q?/zP+2jbHyFtFG52E5oYOfnwKZ7ZXQjarRqeQclCwDhgVyGrT/jWanSWrf1E5?=
 =?us-ascii?Q?f4RU9C3qZET0WBaRXVzmwSuFlg0GeG2i4l5OEydYR2p0oZArCfGVb9k+Crh2?=
 =?us-ascii?Q?ZstzwWV2zxUpk6+exAVG3QjMFzoH0PYwfsakEb/e3wCljsQOXu+nMFCjC/56?=
 =?us-ascii?Q?1RHoEp4mq3GFVC74EFLcylpEC3Ddbyb64BkQP7YW+Y7/jCcObqgkLgtJet3p?=
 =?us-ascii?Q?XA03DyYwVp8Lsy1hir4FnzVO5fx03lwLBIxgTdwTRC7Hu5rqBhONHL7kprGd?=
 =?us-ascii?Q?7EuGIsOTeojkmKR/PDE2mQnF0im0ITXqtKL8fcsCpJUUE3SN2YrGeMZj9fd7?=
 =?us-ascii?Q?6RA0rJj2RDlG+FYOFc6hGv8Jo2mkGXS8dJe7mlV2GNqMDicIZJLuOXZe7Zp8?=
 =?us-ascii?Q?xxrweKKO6bpH7DWJ1dkFfbayV/qR7LHz2OTGpRisLsE8SOc2VyMqX+ZhQUl5?=
 =?us-ascii?Q?23VK5b3UA4jaMRBsQkUt7wCSs+3yYgNBASvY7FjF2zdFiavPMuKA9FoBzBdO?=
 =?us-ascii?Q?ekGJXpqf5a7wj3mb+EAumXKu/dBmjOU4uXamaopxCOSVwr2fjNkv8/Mrf2ZF?=
 =?us-ascii?Q?d0XOfFFWmGY2g8dHqnRyp/JKxYr2gzv6p8P5qCGZAA1M7nEyTcL8EmiH4sNg?=
 =?us-ascii?Q?BpTbJN2nGi08+ZcgiZHx1Qht3NqDcfNMPHfnG+MLBIdM1Q80y//NDNxcL56e?=
 =?us-ascii?Q?tbVDa95FRHXhz3zQR3Llyxh96eZ3Kl0tdr4A+mYSfRl2PGSgE37KTUr2qi3m?=
 =?us-ascii?Q?od+Zap0/vyjmibUTUncehApoBGOXclZeX+yZ46E+Y0kD+0r8tTKlAeKLL8lR?=
 =?us-ascii?Q?NhySrp4vBFHBnA2BnGYq9iNdtHelFtTzSt9ufxxNmVh1FR7P+cHmfPwM3L1t?=
 =?us-ascii?Q?0SYzElJF/rBgIV8acAb/m6Y/+edWDRHuCGOYKOkRA12RVdXOCQ8bKlDh763C?=
 =?us-ascii?Q?GJtHwtCVTvoiefda+SxXbq/XZIlKKGxdRKzWgfTwgCeu4AnoTsZlNFuYvaAv?=
 =?us-ascii?Q?PBdRrpwqJAxXP0WVyCcWuj54mELAZUpc/x/knD+mHGE6ww6pJESy/G4kxdma?=
 =?us-ascii?Q?z8Rj6NQsK41LOFAvPI7dh4E9aGHzVx/b+hEI/AMkmH18QkOOPEeovlUNAvRn?=
 =?us-ascii?Q?TJUaS5i61bKdmC9+J++G7+WYW04E6sDlXxeCkvhV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19959cc2-23ef-4c27-c43b-08db1e42ea80
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 13:01:35.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bYvvQtBNIfhA4nUm83tuznkeVcHYodgVs9yXVOsPawiaWU0A3ggeKVUEpmBtK/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 03, 2023 at 01:47:53PM -0800, Jacob Pan wrote:
> Hi Kevin,
> 
> On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Thursday, March 2, 2023 9:00 AM
> > > 
> > > Global PASID allocation is under IOMMU SVA code since it is the primary
> > > use case.  However, some architecture such as VT-d, global PASIDs are
> > > necessary for its internal use of DMA API with PASID.  
> > 
> > No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> > device requirement.
> I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
> does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
> restriction, there wouldn't be a need for this patch. Let me reword.

No, Kevin is right, there is nothing about VT-d that needs global
PASID values.

The driver should be managing RID2PASID itself to avoid conflicting
with any in-use PASID, either by changing RID2PASID on demand or by
setting it to a value that is not part of the PASID number space, eg
we can make 0 entirely invalid, or the driver can reduce max_pasid of
the devices it controls and use PASID_MAX.

Jason
