Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07116C1DE9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 18:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCTR2S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCTR1x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 13:27:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECF2B2AA;
        Mon, 20 Mar 2023 10:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz/B6iScg+7VgDUHi1kFU55mrH5XghT8U4Iuk/7OIDh+fBkzHCrFUNEX6Kwg2QA+1A3CweT2eoU1OVkgRNi/lvCWoiTNNiLcUE6KtdDziJe9+uZKBdg2beTrr/I/hlDScSfVZLxViTxaFPKwlyH599tbRvxcEixYjbWb+4nlohDFGwAxlg4ae7ThgGlma4kTaU6iPPeKbw37AvygjNi5SPup/6Ve/7XZR0AU/ROAFnJSzGrgLlUTuubXVUXT6x7ZOMq03Zm5Nx1mhA6SPMkxMa/tBTHoQTHpAsOyfWSZJeHx6h6jCBUPka1nBffmnWvm16Bts07jvq7+1Im85nsslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN/XRTHq+IdVoX1lnddk6la5raLj3hGkMjHJI1ASuOs=;
 b=LE0eMbhmDFuebXynJ/A/Luqm/Gfx/WI6opZLaxysl84pfCjNuVC7N8C8PhnsRpT9DDrClIPpbmVx2TaI77mBU6pHjhN8u9W+ocAcvv+60GqVFezYszF5fvqeTupdP3Xjw2Nnp3/HZiwRpHWJU+7nzjWuNS7n5V2jSarHZ+gBYJLGnmbhSGUme26tY/3RExoGsR+WbYwXfOtznFq5Wm7AD+39Poisvdv5HpVE2R8KDQiMc0/UkAjHmfulSjFVAmWQ27b0sScA/ZqqbgAwcNRX/joNZ9/yCFwsMtBPwtLU24OB7Fsrr5fht6L+mmgeJqn5lVIYOmn9kUHhM0fxsP9uOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN/XRTHq+IdVoX1lnddk6la5raLj3hGkMjHJI1ASuOs=;
 b=uE2aycF0q+XU8b05vYsUT3C6y8fi2TQkBHbtwVmyxH6KB00jDbXa/Lmu6dKh+ZO7x1OJJxzflPc9rZ4lfYGaVkOImJloFMvAXdvUY5Pkgb1zPJcdeafCbEDiVOzSsKN72d6seVLQC+5BMfV/KcnS4QAL8uZDEcUh5ISb1AMKvhb17gb/T71XSkZ1QrbALemycm/I21tGc4bZCH6YRgw43/xA9DDEuhHOsje6O6vvrl3md42ltCri+aIe/cYaz5Os9KMfqZqwnEpec+UwxWTlLjqWi4tmbIcvBFTTqOFPTWPi9LMTkVj82g6NTXBYxIIulM4ofqmG9BEIXYvWFvehQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:22:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:22:39 +0000
Date:   Mon, 20 Mar 2023 14:22:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
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
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <ZBiWXlxnRWzbb0XN@nvidia.com>
References: <20230303134753.660d0755@jacob-builder>
 <ZAXkLN39VUSl+t65@nvidia.com>
 <20230306094408.2d675d5b@jacob-builder>
 <ZAYmS4Sx6bm+ziDY@nvidia.com>
 <20230306095759.1dd65cca@jacob-builder>
 <ZAYunPcgSOGFK8Qi@nvidia.com>
 <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZAY5d2MSXjWRGF0n@nvidia.com>
 <20230309090623.7ea2c3fe@jacob-builder>
 <BN9PR11MB5276DE801B64423E7BF3B68E8CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DE801B64423E7BF3B68E8CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba1a3d5-f76f-4a85-acd2-08db2967b4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yINvL5iRwHERuVt6E7YKximRFNFpF34DKQsy7gIIWK1JRaEzmhQT1LeOI9sBE+Bky51f7GCnNVaMWHilnmriu15kxTAgTSZGQKoSeMsj9MKc6je50rFoAok+8ZmGrfY/mr/KR0xApWoQhv1XtL/HQkdcOddmXSxnqhuNiPQSgGLDDHGvoTZLyiVaFWAnKbrHcjz9w/KU6I/baUv/Ky0tLMoI1yVQcTvcA7w9whwwbA8O3WoYaZi4gcX9g25+dpZow0pvX1P+K4VxF+WJY9cZqV1cbu3okDivdH5tQ3wUBAME9nYbAXLz2C/eGjYsLaCBL0AHT3PbSWDApVs7bGbyUWVNIjEkoDpLxnTWKqDeTBcXjFaXqmssk135JSFblc1+OQgpmpg9PeR1W7ONAmR9WL1HhbQVxBfffO4XtLBPtSzc4P1ONfDMU5NZ7qZkrUZVlUfmClRg3UMlDbxKOwaXnc7h0A848N2MF8JJs3kdNnhjBIsVhxhkGtoR/za78bRsRLMkkn/XYTG8Ei+aP88xVWlfzyyFe1WMyYeX19Adw5idr8iWoOVQUkpAywUWZsDtzPxfUuvJYpYhfn1JQAoBunzKl0++o/hVlbkN34gt2NJ6wcCF1mfIq5aqRD9/CI8Diwlucjia9tsuwcGhlf4UjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(2616005)(186003)(6486002)(4326008)(478600001)(54906003)(316002)(66476007)(6916009)(66946007)(66556008)(6506007)(26005)(6512007)(8676002)(8936002)(41300700001)(7416002)(4744005)(5660300002)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9z6+rr8LnEAo8Q2r5hK+IiNZo5DLwkLIZDDPrg1KkY37A3VrxnpelI1t/HFj?=
 =?us-ascii?Q?NIGreclKmz0dvzgHITwC/xyKKWYJvTe9hMFATq6meyQGCcWhsnO7flMuBD/y?=
 =?us-ascii?Q?g1v/xNtoxg+hiLv6Evk4u+sdof+OZwcW18nJzkTzdlIJKPVL7/0tisa4qWpu?=
 =?us-ascii?Q?z0rbef+LhXC7+95rQVdsLh9SyS7JgD/KjKUMUpRnXwMZ5tPjaCKTMXrYMV9b?=
 =?us-ascii?Q?yM0zXE72SR89PyfYt2Ew4rT8/fkoCOe0U1HBjU51uW7n3REhf4m56p1WVPin?=
 =?us-ascii?Q?YD+R+cPLWaJ9cQKNrlqXeJGRrFADxHyHFPIsFtT/iGry/qvdifQpuBrRAQk6?=
 =?us-ascii?Q?fRwS6YGdb8dQ1mvGlWqVrGkokSmfVyOtYuVzvU4I0HetSt9XTD3wsGl05gTK?=
 =?us-ascii?Q?i4QDKE+V5cwb/CVmpno81B5nsozG7gNUPh/iZzgPL10wj3xqxRBmzTBBroBO?=
 =?us-ascii?Q?QiY4+ckBPlh4FVhWxhgi42Ye323XJvxCLuTq+D4gBm7RnfduCqkmd3wJdvqg?=
 =?us-ascii?Q?PJ1fx4uK7gG6lP0Nhe22rPxup/DByGZSyOT9JpuM6wNl7H9KzJJ5GMJEh1ft?=
 =?us-ascii?Q?xhwS9dTtUz0jZHsyv5qNN2ca690YlrzrBegOFJmVD1+97NrBfgnv6Pns7RX1?=
 =?us-ascii?Q?3KQfaXEh3aFRiwvmE8Z1jvsrOn7ebZV2bFWkZPduoKzYSQJN2ZaKN3qvzsIK?=
 =?us-ascii?Q?rOnNOH/aPct73CltgA8AHA7sJV75ldRtf3ApSAK+UbbgqONh9Cjh+xDJLwdy?=
 =?us-ascii?Q?S+CuTIk+Qczlrbgk1Eadmm4tH6tsPFdDuLTD2mqIGJLiZLwEIV12V9kAhIRo?=
 =?us-ascii?Q?F9Eg2cr3Py0nBsg3R/9geh7OUoDNsbDSKHe+t8OkQ8SR+P8Hjix3hhcOdOmJ?=
 =?us-ascii?Q?O6H+wixoXoQpJBMqgx4o0cgBYyB6NhnBCi5wyrOr8CE1bGzwIoSYj74NUTeU?=
 =?us-ascii?Q?UWxbmkWkThVaSSgZKDLifMm8ul4U52s2Jj14Vsgb8wgzLM5qha9ZpLZ6lbTe?=
 =?us-ascii?Q?91Rn6ZL0Rm4hpB4aVa58MVAcUbzKjyg1vRcEUMkBoCglCRNIfcu8YZtJI1pi?=
 =?us-ascii?Q?FlyXGlUPMaBlGXilqAWH9CuXNWaRNxdjciVnacTxlBrfMPgdRdSP1uequcg0?=
 =?us-ascii?Q?7rey8o57GU4b+TijC8Q3YU9aAgOsDtxSzlbzI0ncsOZVXwTqFM30+XyRvKRS?=
 =?us-ascii?Q?cXv0SfM3+bke4W72D/466CsaQkHf6OopGSRDkP00rtD1oV9pd2/EdV0hwJzS?=
 =?us-ascii?Q?GUaIfinMi2uWnq0LjO0PrSvbTywvHKz74KJiJli+AWS/oKoWy4J4KHblawyt?=
 =?us-ascii?Q?gbMUUVX6KSnBVvs6PixLHQkPOSUQjrDoLIU8L8NENuJmFZ5U24VacXxWeIO6?=
 =?us-ascii?Q?7LlNaACKt1MreoTR8Ai1LeFuBhEoD8sWMKXqgMn8RLX+kisUD+SZB6YHasSX?=
 =?us-ascii?Q?NuSZqAawxnKuDGt7XQiW4s5+6GJbZnzd5ifgpfEa60w6ZTTDGp3gYmrV7DG4?=
 =?us-ascii?Q?Oy2WnLX38VKb71Sp3fzyD6qx4s+HH5JNZZ1Al2YqHkV16WNqFPw3TZbkf4Gd?=
 =?us-ascii?Q?2Cwbu3+BOdo18yibGUYwXGM8KZRswg2dJnkNvX7g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba1a3d5-f76f-4a85-acd2-08db2967b4da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:22:39.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XcKfR7GyU9TJ3jmyKK6/MsBbEv5rj1md8OI+iV7Sgx7yWTetIOnyCU3N8yuBU0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 16, 2023 at 07:25:17AM +0000, Tian, Kevin wrote:
 
> I still doubt 'reserve' is the right interface to define.
> 
> for DMA domain probably yes as it's static and one-off.
> 
> but thinking louder when the same driver starts to support SIOV we
> need allocating additional PASIDs on demand which is hardly to be
> fit in a reservation interface.

Sure, it is the same thing.

It is "reserve" in the sense they are not assigned to mm structs and
not used for SVA.

Jason
