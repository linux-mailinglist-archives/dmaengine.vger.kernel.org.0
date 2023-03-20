Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4A6C16E8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjCTPKK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjCTPJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 11:09:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE6C16E;
        Mon, 20 Mar 2023 08:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTg1tXm8oghBNxYqpMuFLfpicaICspeNlfvHqOlGWr0hgXJsMHo+jiZV5nwO0KXU7Z2DtavKWGMEz4Srup8kN0rnTRz5O71eWemMnUDKn3+ciQFt8CnfOluXpg6YaJMsShK8Ke3NxgMHtOV40XYqhOcTaLs+Dr1kkohjHafuAFKUOdyD628Kj0a3CvWSz9PaHqrQnNV7kNOvRaYp/LY3hVeZSXBQAuWM0BFOcklUwsbOkB6fSTTaGcC5Nu1W7z9Q+HM6QFw5830v8Y/r8pe0WR8JkecCzfb5+iN22FkorUG75JAGbDOPvBZJ6xFlWqp0Bs1aMUOXxpnxw+vjhkObmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef1MBxBA6MI0wL9Z4mfxdaFryEBB8N3kTt9QFsUbcaA=;
 b=lprjUa0jSBz02OAvLvz871sP1BIaybh042KttGKhdmFt4+kaQS8KWfeYUeJ4zyohzaVk9ctWSe82AZ9bVhZmvmlenF+2FbhNyEvuuVbpwDb1AJS+u2BCbcrbHMfNJmrd//B8pNfL+0qk+G2QK8GPutFAgz2IR21ra/+tDELopNysaXl4zfA1Bg7vOnHCWTKH7AiuFxh9MsNXGjcqakw8LnccYVdN5XgKrue7fY8W5lbpaIQR+o5RIO8a5imthHRt1n4y5F2R86PSwEcMvUzvnifKyL730H2LTmKOfa91XBY6hPoCMGM8z2R+dkGt9buOJ4IBJrsDZlsdcO8IskyF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef1MBxBA6MI0wL9Z4mfxdaFryEBB8N3kTt9QFsUbcaA=;
 b=cn+m07TKBiOQ5JMCUeQWrPoZZfRjLKlnrAwCWPKJHnT9+2743BrcnWvgX5Z/l/MR6SZ2UhYjiAdIg/NxDR4T9e85Ksuevf9xhOo33JOH66thTif1ne8tm7xtguH6A2r/3ubziklUKBwA+NkX2AbWh198kBlA1xSkkK2OrH0oiTnUlP8+MHpg2AZUNlZviA5ycWLav3vRFciYHEghbRcU5b//xLcFJ/pQdN07n3VH9Ufic3fWFHPeHoBKFLv/+aleSSUJxJ+O6m8g+FTq8/YRVPE65lRusd76zKwftIyYkYUJXVBkidXk68qoNgQvwhIF8ko9n7cuJnhQZ86N803qxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:04:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:04:33 +0000
Date:   Mon, 20 Mar 2023 12:04:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 5/7] iommu/sva: Use GFP_KERNEL for pasid allocation
Message-ID: <ZBh1+QcBwsl/Br4+@nvidia.com>
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
 <20230313204158.1495067-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313204158.1495067-6-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa62f1e-bf40-478d-c725-08db295469f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fzf2y57O7TK98XZOYHf/hX+XwmmXbPGzOF/xzfqPC4GVe++Swe2kxCcfdRHUjGe0lVThcApkMHK/pDxWoVOty51pqS56IkEITaCTys453JVaoLeJ/ml0SgKzdZM73INdIYt84Tz7oK93/itT86NoAD3d4CP2JPiM+UD1jmHX+WGkAe7x1UaSrHIUBOmev+Zt+5BZNFjnBGJ6+JJwXWCtFI/6xl1DvitwCpnyespT9i9D7L3Xv1+71IaJeRAGRBZYF0C5/6DSLO91KHRTR2RO7u0t7nowIS7119pJiYlpmcLcE95HOEsxzGBU0IsaoGxjO4w0+Wfz+v4tODy4jIh6m2P67YG6VQwc56ToOEwDmKX6fu0vhV1fP3bIi4twrMGijcpk4C/lX4yHHvBZK0J7NoIWI87ln46Lvp6I1iwLOc3ex6A627KjhwvPBECkZnsP9ykdp3q2YF7hbRdqo07z49QEg1AwY+VQGxmoNpco/ajKpNBX+rgWhuXLISVJLCvt9betpOKiwwwzIf1kYtM0qjSqZL8FnNWHQ7MwRP1jez4uuYWXTlhi5ZWvLZu0oA9+je+nfplE5sgtl9P8IvzgC8nxpxctUiOWSZCULh0pao+/9A0P5yaky731Sfa4Moh/ijIFBBm6/WO/oD6yJ8FA5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(346002)(39850400004)(451199018)(2616005)(54906003)(83380400001)(6512007)(478600001)(6486002)(6506007)(316002)(5660300002)(186003)(26005)(7416002)(6666004)(38100700002)(86362001)(8936002)(2906002)(66946007)(4744005)(41300700001)(6916009)(8676002)(4326008)(66476007)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdmMHQwdmJDL3ByQ216elY2UHVvVUllMEhMa0xhKzUrbjk4Y0plWTR4Z2k2?=
 =?utf-8?B?SUNDOTRYQkkveERkOFdBbzA0UC9hZ2N3dDBGRTErN3NMYXVaa3c1cHF2S2JT?=
 =?utf-8?B?R09sWWV2eWVyQTdRQ0xLTmJESjJzdWxZOUdJRXhFNnU4RDBCTGFSUDRBVkVM?=
 =?utf-8?B?K1NiN0ZqR3ZXNTQwMEprSFluRHZTTFpSRXlkQTdISGlkdWpSc3NUUG1oZHpX?=
 =?utf-8?B?bGpsYzROQ0VzdExnNkowdXRweTdrSXhxQU1Ga2NNTTV6dy80aExsRXJDdmMz?=
 =?utf-8?B?L0VKQ0JTdkJwWWtCamJVVE5Tbm9oZ1huQ3hWS2p3blYvZXF6ZGpvdTl1azlY?=
 =?utf-8?B?YzVaNFJzYjI5ZHlHZTMwTTcrMjh4UncxWWRpVmc3NVZ1UXcrOEUvd1ppS0RM?=
 =?utf-8?B?UVhMY2Y5TmZISkN0WTM3QnRhU3RYTVJzNldZT1RjZTBrWmRUOGhvTUFoTUxE?=
 =?utf-8?B?NVZSeTI3WjJ1ZjR5Skh4OWNTa2NEWGx1Ly9qaVNhNUhKQk9wTUZpNWR5T1pR?=
 =?utf-8?B?ZndXdzRiaHh3WFcwOUpKNnc1Umlac0ZLM0RlTTZBTVhZQ0s0RFVTcXB4dTRw?=
 =?utf-8?B?NmluM0xSSUpkN09FZ3lRVDB1Zmc5M2FqQ1UxVXFMYU40cno0TU5ZUzlXY2Qx?=
 =?utf-8?B?bzYvb2h2R1BzNkhjRS9aWVlkeS9iUmRvQVYrZDVpSXJRTFc5S1Y3SzdNOEFv?=
 =?utf-8?B?RXJ4YVU0QUtISGxLWTlCYm1QN0ZaRGdibjUwSHNHd25tVUk4YTZ6cy93MW9k?=
 =?utf-8?B?dWE1ektlUmtqcVdDMk93NTBIbnJpY2tzQUlKVUVLdnQ0bENsL0lkUGxGSWl0?=
 =?utf-8?B?bnkxdlYxdVR1YVQxdUZNYjFldDVybGN2K0xDK2RKSjNWOXlsQ0FlOTJLN0dX?=
 =?utf-8?B?YXBwRDFELzNzVkEvMmJwbE9QUlA0RU1MRTUvQmx1K295ZHM5UncybjNVVjlH?=
 =?utf-8?B?VFFJMkJwbVRiM1ZjSGhDaGI1bHhQOUZoN2t4OVNPTSt3enVZL0NqQjhJVzY4?=
 =?utf-8?B?NTNNTFZVTkF4cGcrcUtFTXU4NTZLRjc0bldtMDJvdkxFcWF2b1VCbDBabzhE?=
 =?utf-8?B?U3IyK1A4cjBqVnBidmh4dGJWQmlkNmo3cVU1ak5tZjUvYUw0WkI3RjhEM21Z?=
 =?utf-8?B?WHVDYkV0UVJCcXhLQW9wcTUrRmtVVkp0S0hPUGY0ay9Da05qeWhRVE9jb2FM?=
 =?utf-8?B?d3hjalEvaytIVTU0WG0zVVkrZTlrWmpUUWR2TVZmYjJCMFlwQ09ISW56ODE4?=
 =?utf-8?B?VjZuYnc2Wm5IbFNIdVhld2FXOWJENFZTNWJ6bTQ3ME90cTgzclZFVHBiYlhl?=
 =?utf-8?B?eWdIcU5FV2xMRGU5a0dXUERXTWdHNXBPRVJEdkM0VWJTbFBpUERXSGtWRnNu?=
 =?utf-8?B?dEh3L3g0WTlFV1ZGY2tJNFVxQ1hVSG9SckdkbGs1RWl5L1lGZysyV29YdEdD?=
 =?utf-8?B?MUdXUk5QWjJ3Y2FacmM0blpPdWRsS2IxZnBUQWlzZjFlbnFmQ0NWRHgya3dY?=
 =?utf-8?B?ajh3MDRPK3gvMm00d1FyK2tYenNCeEpPa3FoZ0pQeVQxcngvRGtVamIwUDh0?=
 =?utf-8?B?MFRweGRTMXM5TldoUnhzdU9HdEhzaFdhRjF5WjZNMFZ1NFRwVVdWOEdjc3Ar?=
 =?utf-8?B?R1kzWHJCa1ZyVit5elZvY1R5YWxpQW4walBmSXdqbk56Y3RhYjgrbE1ZOFk3?=
 =?utf-8?B?TXQ5MmFZTkJtZnFLN1NWSVo2L3hQQ29XZ0xoVEVkejJmbmZQcTFQZnIxL2tJ?=
 =?utf-8?B?RGhHeXpSbmdIV250OUtjRWwxa3RKS1lONmZWUkJPZDRlU2svYW5NTXFYRGla?=
 =?utf-8?B?blR6bjY4YjUrRWUrR2YwZTBJQjQwRUlwYnkyd01ocXNJWmtKZldsZTlzMzNT?=
 =?utf-8?B?cDR1OVJ0UGw1dkx1K1VYT25mSzVkamtTenBsRzJOcWJ1ZGo2MVpsSUtZZ2Uv?=
 =?utf-8?B?ZUg4UW0vQ3F2d3YzVmtLUDcxaVJUQjBvUXhnd3VNTEF2NkRVSC9qM1NNS3lw?=
 =?utf-8?B?WVhCMU9LdEFxTHR6U3BCKzRCbTV3YUE0SVFqek5iVFNUU0RSRXg0dlVrMTM5?=
 =?utf-8?B?NW80UFJQenowMHlxRDZTcG9OcmU2YmVNYjBFK3hQQnV0TnB2eG1lZEdRZGhz?=
 =?utf-8?Q?DLfXxuXYXMyDWBGFlia6H0A6T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa62f1e-bf40-478d-c725-08db295469f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:04:33.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO2nxO590c1yqMrhG5F/T2+2iBDXy9HNmbB2e/lPATKTckU7a0mHm9BNPASr6Vdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 13, 2023 at 01:41:56PM -0700, Jacob Pan wrote:
> We’re not using spinlock-protected IOASID allocation anymore, there’s
> no need for GFP_ATOMIC.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
