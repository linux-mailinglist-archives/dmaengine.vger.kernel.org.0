Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22B26D2BB8
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjCaXbR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaXbQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 19:31:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2D12CF0;
        Fri, 31 Mar 2023 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305476; x=1711841476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eqPP138TaK57c1S9Lo+rZ6AhgwF9ukTPzloRCJ8xmkk=;
  b=cowDegOEOPSfatW5XQ1DDiZFbtgTCM60d0m2csbLvlL+c3Rfu/mxL4W8
   zOaYrLyyGILRUulzac5OiVjvh9i6l/edC2Mb7atrYIIaG8IlRjYZnBBqK
   bWWYjoPOzTkgS71A3IqBupNGP3DV5WUl+2VyBp2laPmBDwyzvEb/t2Mdi
   eWYUk/4R9hZRKKkZXahV8jAOKdi53KOQPHvXa3T3v1cHv4MQaptMgxxCU
   h2IRJdrJbM4LOKlEScTDgggvCBaRGCnkLFjRyN+1xX4BKeWaNfv0UMhb1
   hhSIn6YerD6V6Z69SSbCeo7yWODQbIxwNc2tg8/vc9dPucAZPP3hdDr1Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427855868"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427855868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931351334"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="931351334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 16:31:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:31:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:31:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abTxpz0eyg5yD/4yPhUjhJLdileD7YwPZbBU7ptiFGan/s72lBp0angLpWOgKYEbOY2V3XF15ypHLmdB1XkW61heJgmpNcP2cDwGR+cUhZUNfGGjg9vPNcCXUTy05nAnegg5YcRcFhHuI+LlcCg49GmsOZz3/HsCznIWChxi3Mz+8OnlmyxlQMpOH4PoM/Xrg5q3d8whSD5hku+g10vBLHjtajEa0axrk7H5c5sbimfQFa9B9RbgYVH0h4hG/nGVJI2UfdwlNt6XV6Ph5L6As8MeTkpeoOJLDNDareof9hmJa+8Y7vzuoqLpuQgnybbSTlt6/06Klds2l/nRsI9e9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqPP138TaK57c1S9Lo+rZ6AhgwF9ukTPzloRCJ8xmkk=;
 b=A3URgPE7HjooY+rWMwjIocH82XVZsbSvH2GZ0PQbI45tOwn/u8oJ9CuWb7Xd+ZIBwp9XipQSKGbxmVWHrKOIh973Z+Id+OD8ZiubeYf+B1zOub+NyXziGfrw9kFm3Th0DHPsddUhTWky/xRFfxJCe6ltlCeXDu/RqD2TEzkwUkDboOA1JppcBzWTt+FEu2L0axZzP1cJ47IibmZa0WO9WuDrVHgj3O/kuyoBapfMNJsSTvhgJrCVZvmkz8anSzdsSwxx/bBIq9mF7aVV9fkAg/oxdF+FR0ZVlTpEqwPeWP3qiRzk0CG9uKvkA0wzu551QZYtObYC732+tYxSvjBZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 23:31:13 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6254.024; Fri, 31 Mar 2023
 23:31:13 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Thread-Topic: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Thread-Index: AQHZZCWaCgY3Jdq93USwu66veGT73K8ViPzg
Date:   Fri, 31 Mar 2023 23:31:13 +0000
Message-ID: <IA1PR11MB609783D2D1159E4AA6F6099E9B8F9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB8199:EE_
x-ms-office365-filtering-correlation-id: 821ce288-63db-4368-5ef6-08db32400427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuQMqe1te91UNKHEyem6WlPuWbCVfAA2xV03boAWkmKZw2emIPK1YE33HORo/q4NJ5WfCSZNdotX45smMxJqn9uBTu63cHtvbZqbHA9SehbAa6DVnv3JOC61WwYbDyNtPKS+6F25fal2uhI5xoFSKlUBrLw6b+BV+p+7pfU3Kf32drKKyRceeg0QEAtYfyOm0flwrsr9jTCYCaB0f0Z0+6S/w8ZAI//185WagjahG2w23gJUY9EM5yZ+cVpI/AKaesa8IyJm5Ep0AfmwdhJ9eKE1qSt+S9OqOWDPpHvYdEXLunm5FV2RBLVz/lb4ByIrMeit//+wm3l/6EDMXT/xBHCeBksW7TFQvGnjLI2B/lftHe7WsWCneqUD49yPQ5Y5Iagzcbot1NptC8X/2l3LyNTc0xz0H5scvsZc3ZFN0vVVKSx8ZAhFtwkmqo9MtxDqBX54Tqv0QlQ61Zj66pbldHTKWPC3yIIiUBifHkFqtFkO0Rjr6tl0HQqoMpA/PgtbZrP9Rfgeyzegc1pVOU6lCzBxFwSyrJrPRg1gIehJ00u+uRlZlKELlX1CvdqP4Kyfv782Aeg1/5kM4FlSbLh3TVI3kC+GCTDIq5On4SfLfn4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(7696005)(54906003)(122000001)(66946007)(110136005)(71200400001)(478600001)(316002)(41300700001)(52536014)(66476007)(38100700002)(4326008)(5660300002)(82960400001)(4744005)(7416002)(8936002)(83380400001)(2906002)(38070700005)(66446008)(86362001)(66556008)(8676002)(33656002)(64756008)(9686003)(76116006)(26005)(6506007)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lq0RjKYu4Fc5QPLEPaCP/hms2EDyNBbuSrusCg4NWs3oykVQ8Rhh/Nmx8KDh?=
 =?us-ascii?Q?6wkLvYrUbd20zQJaJ96yzOZIIVKC2H1t8pMGg3BTV4wb/CzVdLvcalR/rCr6?=
 =?us-ascii?Q?ggKhxryvf5OpLnhjA785E4N6/UmGcskzg7bCh14oEziRcUiDtmmi9+1cJ0/7?=
 =?us-ascii?Q?uT+mABVY6oMBmgnSVTBHP2rI8B9ZDmC8zsp81MAfOiAWHHLBKBijFIbQPL5g?=
 =?us-ascii?Q?t6qLznvED3mTV7h0X7TA7rhbTnRQkmpaxhFGbnJHVSIsQnF0T54QTYp7QFxg?=
 =?us-ascii?Q?aRmee0r2WykOxsk0DcomDo9D8eFD4UJ/m0sJhWI/YSmB8BH6SoA2o4xNniR5?=
 =?us-ascii?Q?c26x4zs/LDgzmxI1Et35+LMbNHvRRg3eheIyuz/mVpVcp1IDcW/UU/PDOwsB?=
 =?us-ascii?Q?HRGvsvIcB+3FQteEhJHwjhzrpZMh0ar8TuxL13yjBk7zYYHJohc4kMKOoXHi?=
 =?us-ascii?Q?YtPf8yUTwRnLVZfKWIG8pq9DBzrOFg7I6Gf8GNXcjjoVjZuaf47ubhBDZEd+?=
 =?us-ascii?Q?WT8UcfjK1RRsNWIB7cTH9P86+ftwa6yobfmQ7uwxUkDNZMMo6BPfQF0XyLZW?=
 =?us-ascii?Q?2XAS6LSDkzDjaGCQ6htw897FhJjXxncCBt/th7KEQCEmiAPB4o184ZOfcY+F?=
 =?us-ascii?Q?wtrlC4h/FpoFc1BBwlH4hGwbXoVaxFQenJiS4AmHlFslBxx0Vz27NO2skZ11?=
 =?us-ascii?Q?raZMNmWR5TLzjqdp9YCRvxo0wmrPW3lCUR5neyVbF2z3D6SmKQwISy4fI4OV?=
 =?us-ascii?Q?8NmtWo7T2TnKGXVK9PJUT0oynHtOuJ4F9o/5SFfpg3mJsb5oqjymeRAfRUnL?=
 =?us-ascii?Q?Xudn+LzYOS1PKWQ1XJYIYbsfZ1MP7UrNzXsLcND58rcuj5o7MBvaQo91W+1z?=
 =?us-ascii?Q?s1RzAS4TnFcXUABA74IZhndITcgIQSvkpjAJ2DmPN9WnllkHW5sVMzdVgdsc?=
 =?us-ascii?Q?6rNnXjV07UTT1Nfi7B5MpfCTD7JsapAlsdMs1LLODkC0guPXKB00Os22L1F/?=
 =?us-ascii?Q?u6FicD+feicycFxwVDJ6jjmKoaM6jnChqIxCLoYne59Lr16J5IYkvW4LVjJu?=
 =?us-ascii?Q?L4BZQHum52kX1ssL0MmYZkVXDx7dQC5BEGcFSNqQUnWC1RVtWfT7zvOm32td?=
 =?us-ascii?Q?boFDNT/V7OLJvHbN3z6i996LIe6TzTla/BnSppSiGGg1VQVu2uw2GxQGzikA?=
 =?us-ascii?Q?KLFi3x74kHQniHFikxbtRLlMI5oIg4eZQljE/BuyPgTv3GRnIeoNAGsuf2Vj?=
 =?us-ascii?Q?y8sM4/WRxYpZjaMc3OdcO415a1g/YfpNEPOiM9d3COndx25GhVspKf9fBbKE?=
 =?us-ascii?Q?SQjTSwFaeiy0HQVQEhDkXyAw3Dh/wLRPnqKYE0HI8YFRegOBV8ldjOVfSUy0?=
 =?us-ascii?Q?L59KAu4xCIJ3m1hghCmRFy/O4zok/RjRy+42HvD76uuB1ltKNXnU8CLrAiit?=
 =?us-ascii?Q?p/vvXTIBgwU8ZWKLODxu24onDg95TWRKC9FkbQQZT+DlSQPLuraohf9fjZ17?=
 =?us-ascii?Q?0chsXwBa9ywQS8GKJlu9v7eh5XUFPuKaIIBjiQha/3uzMbtTNgslEJYlAzse?=
 =?us-ascii?Q?eqhaSltDvTAlIrWZBpT7tXKfBjpRMfoNTKvdsbl9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821ce288-63db-4368-5ef6-08db32400427
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 23:31:13.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0l7SGDPsfILozzLJrsFjwbJDVZt7GvbWyhANoxZI8KaCZpRCFokltiWUghlzufNFb8uWDt8hhVRzRjaE1X/KYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jacob,

> Kernel workqueues were disabled due to flawed use of kernel VA and SVA AP=
I.
> Now That we have the support for attaching PASID to the device's default

s/That/that/

> domain and the ability to reserve global PASIDs from SVA APIs, we can re-=
enable
> the kernel work queues and use them under DMA API.
>=20
> We also use non-privileged access for in-kernel DMA to be consistent with=
 the
> IOMMU settings. Consequently, interrupt for user privilege is enabled for=
 work
> completion IRQs.
>=20
> Link:https://lore.kernel.org/linux-
> iommu/20210511194726.GP1002214@nvidia.com/
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Other than the typo,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
