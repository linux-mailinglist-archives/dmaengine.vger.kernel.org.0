Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B36CC731
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjC1Pzp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC1Pzp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:55:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CD187;
        Tue, 28 Mar 2023 08:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv4UfeAgIg8pHsfvU0jy7c9QKA+12TRziccLnbJaA+js2YPGoSvVD4mJLYtcFIv84k/gmesLQpVuDl79LMe6KuxwEK0t0W9nF8KHmRCNiH4bXZyQpdouI0OboiRMBb6zj0LUzIPVqhWZiWB6Y5xjiQu/4OB3fe1jPk7myTOEhEPl3wJcKKhzWPzjN78UGzW0qDwTV59tKv6b0cNy6iXPGU+y+/h4Ono9e2t4tNMTqblQD9OEzzYI8G85Uty9ywePL+SvftXq6yzgSQjHD/jXnfZGXszEeHjRBCOE6i5IVuZQaFlZRbHBa6Eyq08iqUCnfKfoEU7zWDG5yc5Qt2Uqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie7ky9zAzL/3rdjq5knRndHwxrHLZPUuJrI8bSF82uk=;
 b=nm7ZMt5SNBEV/w/2yEqp5SzuGc5qYe1tTgAYvfWiDzFT7c0QzG7YaxYnqResTnpi5207AHwh7BM20eff9pgv5r9zMkoGlJBciRj2u0xTvKPj2mAZSf8L5wKsvnB1dSFI1lChVF05mgZzvcR7wwWmLAKxeWX6Gri6PSTk+9vSKI+y8DgDaMyEuo6HBHykhMcWbYslehSCp1Bdf729tqQmqvjYWRF6ShaAoaacisiJJgXRp0Kjgm3Zr/okYCd8lVOaRqFt1Xh7RwezeAIN2jgjsCb0gDqKyOHRIZRZwLoP2e7hkN1SqXjgLCuhEK9nDLHmW56x4MaFB1WSJNzGOLk2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie7ky9zAzL/3rdjq5knRndHwxrHLZPUuJrI8bSF82uk=;
 b=hgkSe0TasaJSemobKRwXTfRIx3KNN2zx9kg38q+qdcTul71RWtLJFo7UiJtVib9Y/kcjfGyTcnhbn3VkLMfugwusMzIERGSYyexzb672Vvtt8upKXcXtiEmoeQEMDbACGKfSoS31AxnMpHc1Kn9VU+8s1KOWyK+yjbd+k1YYtgHRMDoWjKcTrB/PfDw9sFHrxKi//KINWm/HTlYLPQpKSHVLAx22ltVflVvP8SVr+Ft/yfjX/CBike1ZVCSqkj3DXm5+18WNf83TJiRsZ3tJY6GXwrJgRwU3uVe7JkwRojEu1EV1RMDBm7ZR233o5MC38FYfmCs2ocdTa1TMGE1Isg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:55:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 28 Mar 2023
 15:55:41 +0000
Date:   Tue, 28 Mar 2023 12:55:40 -0300
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
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <ZCMN/LhCgDfwz+Z/@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230328083110.294a327c@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328083110.294a327c@jacob-builder>
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6554cbeb-2081-4f27-2a34-08db2fa4e21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WH8AOPo5YQmwgCbOTVFFa7ko82mfQ8DYHKhCwyWYTZ8VK9+iKFkcxVNkkYA9vigTsuDxdLb+VSdm5D4O210PZjz92hIO1Rh3eBuLzwgJ5XgXmlCUMRAZZwDMvIY5mxOFq4iWNkAK1nlXVWctaxFjeBkspTbB9JUZzLxLduYcA7CWdvpzYbMbNz97D8BzA+IgBYY3YO/RdQJmNvhG4KCP0nC9Mit3y3pVQ05IkapBLNe3KYVWRD22go8A/khNXh9cnAgKEa7RocbSkhUTOJIJYQqwrvftt8I9qFFMl/Bk3Chlb3de/IvPrLXVAvmEdX+/vJ9P9BxiYoKl9z/9l5wSIJZBNrLfEkRgCfp1KDoSsO62pTn0SU5smnz7JzN1rAtic2PZusFnrAwaTczVgtZtD2cyLBnw2u83VuD2QNC3koyPktDEvYYfuAQXGDHoLCyDdtnzJwIpY9EGIkIQJX79I8NstYJPC6GQaj9ArLol4z1c8eeweDQc6eqiMDN1EWOX2DjgLPI5tH4U+jTzUg1LfSwlRT3gBR8kQlVPkHXc92vWuvIg33Rm90HzVINRIYnd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(7416002)(8936002)(5660300002)(4744005)(186003)(2616005)(38100700002)(86362001)(4326008)(66476007)(66946007)(66556008)(41300700001)(6916009)(8676002)(26005)(316002)(6486002)(6506007)(6512007)(36756003)(54906003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKV7EXL97aT550qh4Cz8qVGktYfOJmBHWt3D9dc8aUFoJHpIe9qq8v8j/V+p?=
 =?us-ascii?Q?dsFUEwUR3oIcwBq8PCfTeMun01h5ocriDtsA9PmusZzhxpU8YJPzpfmVsd7M?=
 =?us-ascii?Q?VVk3bTFdXAtXwkP0sJ0ROdNjukJacxqzzRsOParBUtXsMeJCe+duMzkkG39Y?=
 =?us-ascii?Q?4D5QM2AGIDgfOSW4+oQJKZEMgbkm6t/Jyj8WZSCX8u0iVoXl+S/ukRZT6WK4?=
 =?us-ascii?Q?/Ch8+vWcSEwtBu3IaBJY2oa4bxSkFrFjlIAnud8cN6YV0W2fMU2PH3txW4C9?=
 =?us-ascii?Q?0GSTvXK5Qvcj/3XkT5B01SGO4Yhbw3zvLOZKxyYl+mgA+wncFXo4iYPAWTRz?=
 =?us-ascii?Q?NI6bbP33OU49VC8Hhny2EGFb5oob+jloTU84iMepDm8lcXwblCfTm7IjlaeN?=
 =?us-ascii?Q?uHmOGcxeFYZcZKLv4+RfbVO7eH65xCMOMJiw7CK8wMfdHp3GkVpyAVcPxbT+?=
 =?us-ascii?Q?jGOjrLUrEn85jYTD5BqZn4mRfeupLRNs/Q5d5PffCIvD9EvSWNmLedp4CAQT?=
 =?us-ascii?Q?hcHNRFwJcna1Cb2fRC2lIqoxxM+RYzu6i+eXOevfNVtWWlhHxTrInUQkxN22?=
 =?us-ascii?Q?vn819B+4h97ZN1+T4/JN5y7N/8ptuuonlUS6v8loFbrk0t3igPdeA2pbcYQT?=
 =?us-ascii?Q?uow6T7uNIzumFZssl1muPRvtetN59iPnuXA7fzeclo8YKNNwUrphnUN+vDuM?=
 =?us-ascii?Q?p1zZdERYRUSH171EBBulFxcFkFVgCYoxNMk6XTEW4wtaehxAqzLoVieGAVwz?=
 =?us-ascii?Q?AD2XfFtzxHwKQM/P7mhcXjvlkisM3Sx3Bp2v/W5w8E7g/lb34pa2zfoXcVl0?=
 =?us-ascii?Q?NDOIxDajXEgPIhxRiFWcu/5k+vFG7jXXVUoYUDgCcRnH6QrH7//fu/qLsdE+?=
 =?us-ascii?Q?RIlDv2Opsnqs13Kp8lZnhDErGUdq6IUsGGQhsla6s8NcM7ZwwXMceu77BsvP?=
 =?us-ascii?Q?P4WyzvNZv8edKtSrNtyGCiJHRLQZle71OpJ9PmrDHucncg5ooVg5Y/LH0Yag?=
 =?us-ascii?Q?CpbFf0qzNHpX4v49v8QbnpHfeslNpDGNUjHbA8/aWdMrw5NpLON1kpfkg1g8?=
 =?us-ascii?Q?ctx8Afpbha2uALgrDWykN6uj1voRY8MkxflpYse1X/jdeZSKiATFa0noQtLr?=
 =?us-ascii?Q?+GccXl1oospRJYN2uOj8YG7Q3LZ6HkCgKAf3bdn+P3zLrMx9uynpHstWvTwX?=
 =?us-ascii?Q?ZcucwPgZQbSX31X3a4upvVdzdXh8EQmM2qXMRIP6rAmGG7c342ww6tm5iudZ?=
 =?us-ascii?Q?ICMIZGV5Kg8JNeZu3XKl/nrb5ymUJhILCObrh3aMveYpPbHAR+2sCZgu4/VC?=
 =?us-ascii?Q?dJrfewBoOi/IjZfUonpL3lyAj29HfpnubDEROAzYXLZAiPh92Ao50WOXR87h?=
 =?us-ascii?Q?VDJKvC+m6Gzcn2oYuYfXpf36UvH/aynEbMGVrz8HAOBAqrr894RIZKoi9Sw9?=
 =?us-ascii?Q?DomasBBN+/0Fah82PtXTrZ82QpfTgrUYnqKUTE1HliXyHdIq9PWUD6eUDFYn?=
 =?us-ascii?Q?3IFOInFXlxIfxjQcjBfnB803UC6k9+CoQnTTSfeNE3hN+/NgfCkBc22VlETp?=
 =?us-ascii?Q?TLAJcTMMl0l5xiq23tckwza+jnvh4Sb5aspXeRNN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6554cbeb-2081-4f27-2a34-08db2fa4e21b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:55:41.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtRsMddcD5qLkpI3LXE7cfoZqPtpk5BhWLduUpLKFF02jQkyyGOW093UwNi9cogx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 28, 2023 at 08:31:10AM -0700, Jacob Pan wrote:

> > this would be future proof when the same driver starts to allocate
> > more pasids for other usages e..g siov.
> I don't have strong preference here. Jason and others?

Oh I'm all for getting the word SVA out of the PASID infrastructure.

SVA has nothing to do with PASID other than it requires it to work.

Jason
