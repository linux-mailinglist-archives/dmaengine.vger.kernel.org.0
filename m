Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC6D6C75FB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 03:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCXCoB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCXCoA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 22:44:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0D1633E;
        Thu, 23 Mar 2023 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679625840; x=1711161840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24FBbr5vsUgN2yq4qFWjEaqYXl5dsrEQuN6xvMGgz6Y=;
  b=kWosR1KptfUj6NdlXufUi0+SI8MoSep19XSc3KCQrAnwDHsoVER+oa8o
   4kG+J4fPz26+vyWE5LTNIiqVZBGCnuK+T9fY8CYcvTs463qnrueH0eK9r
   XMGTjDqDRLBaPaBp9jHZYPvRF/pMvXyaX+kXlZsvkSJBnELcOklehu7bu
   CMPqzQIBYpEMoH6G3Stt9XXTsrAWeD3Y7uabx+JC0/xnSTMqUfYGjzaYn
   hbS7HFfuuN0ZbxLnJXTNyrov7JDgA0YgUo1AgGP9R7cb+D1qMqWhsrEHI
   DAm9k+1tDbkmcZ4I5X0/1drIDCc7h5/eAYGtSntix9uOFzcKF7vKg/j1c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338404168"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="338404168"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="928472859"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="928472859"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 19:43:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:43:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:43:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 19:43:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 19:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRBW4+/Uc2WRs+YPTiJzgtEtrlTjssLIcI9J+N9PFh0IXz3rBiT120k9bONZX2I+zhkRlddfCbY0TfBYANVTdlQFPUstBLEcKZWaW5bQiD3nrNTO2qYTSxxRsi30g8Ml9/sYryzljRrDJiQawV1zpqte+Z9APBIjnwf90/z4S+oCF9XCr6hjc1ETYXzYEjMST1pz0rh47dxqT9S90k/O/v8Volkc4zVnbIyyMxrEmfRAhp1BHiY9vm8g6/G28QY54E8b96aECHjKfF5nAWsf1BxrxndH2P2fbOF7thML1z44Z+lORLbpaP7+Po2OeMygUUyqfwok+QDHg+EDs743pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24FBbr5vsUgN2yq4qFWjEaqYXl5dsrEQuN6xvMGgz6Y=;
 b=O+srhANvHE6Mv/PftcJughj0JPWv0iHHxm8PNmemf8r5cKIBrhkXFpgc567T9MvtqfqGImQmaQA2aoBwg2Lvjg96TQp0ypgaq26/I18DHYpSUw+h1evLjEtG1Dp9fiRqWS1x6fJzHVw/SWpbozlbBe5WEcx6IWSbxtVBUNaXR7WKt1OR6nbf9EvLq2JeU9+FNyj15tHRu+Rz8pzdWkEDC/WVHq5G69O43rkR3O68RZ+C//ph1L6wsRZFpXUZlzKt0b2/jxcG5wIZNl2menYxSp4CKyuWEwoopXqBuvHtkijETanOi2dDBGOkn0VdgAih+Ep0JF4l3BZy+4fZFm1CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:43:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:43:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v8 2/7] iommu/sva: Move PASID helpers to sva code
Thread-Topic: [PATCH v8 2/7] iommu/sva: Move PASID helpers to sva code
Thread-Index: AQHZXPl8QO9Ky2RPDEuo8BcyE9Cs2a8JOuMQ
Date:   Fri, 24 Mar 2023 02:43:51 +0000
Message-ID: <BN9PR11MB5276BA1A8BA586D0DD63F0048C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
 <20230322200803.869130-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230322200803.869130-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8363:EE_
x-ms-office365-filtering-correlation-id: 907f9ef4-a156-453b-ee6a-08db2c119a68
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bM41vBD12FX3ksGT4egM1WlVaSGsCr83pr6WBBth+XYhxX7VtFVy635OXNjD558CVV8Mz9lKWn9qSV/l0JcYPBKXFV3bMejOqMGIqaxNSrdAbbtI8YIYk8HnnZbEWoGKl8IgqDWny+jAQdsNRl5jWVgdEQqDmaBAT4/q9Nr2OhCfIW++q2Ou0CbyNhUFeqK5X7UYS5TrfDnBECtG2bOPUbMCL5XgqOVxi8k8LylrsjNsDLee4gK3I85CEZvngGuW5SWNHEKvkxHKU82+f8ZJSubKrZvrhU4BaZ//MMXMhsyiNffEeNK+XNV0u+PlAaENcI6TmFbXeY/sUW1OXcDt8aKe91qMz3lTLmPcUHpFlTlnzTqKGXyfLvtIWQhnVDUAJV6ngPbcBnPVeDR0OLc8A26/k4W099ywsg50JuKry4ZKKL2uFV9Vr1CL5pDPrPEIy63WtG3/1uCoYjeZhTXclH3Dr93B7ik3zjvQSKWWJe9GhTk5oZjcckyELWzLe2pglw7DaG59mZnDlVu7Mme91NuVCdjE4UXGCizOw8/L4eVg+5mUmev7NaBa1KyO39FEJF2Qwt0dC1DwWGu0NmOGPPkwCSh0ygqZgiVWeNsKaLw0mCo7mNrouRbgAnb4JgYmyNR7dNf+EEA6Dp53VfNygWiGtk0IhDKo84W713MLIPBmYGk2khXDX2auJhn5wdyhTAF+iuLcyybDWLA/Oir0+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(38070700005)(55016003)(921005)(38100700002)(2906002)(71200400001)(478600001)(9686003)(186003)(86362001)(558084003)(33656002)(110136005)(7696005)(54906003)(76116006)(64756008)(52536014)(66446008)(8676002)(4326008)(66556008)(66946007)(66476007)(26005)(6506007)(8936002)(316002)(7416002)(122000001)(82960400001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CUYT3gFFBKPu0pcaOKV9xHctnuZTTwlNkp4Aas7CpXLT3CBsEI9ATEZ+efni?=
 =?us-ascii?Q?v1vAC35Ya2na2cC0uZKQYtM4/N4cVgtKVmyfxfLuIxUGSmPPn/hFra4g9GY8?=
 =?us-ascii?Q?WunJnVca9uLxYwsIuG6jiUyErco/ucLJeI4RamRRLXnDEXiiP4pM4VE0wJbT?=
 =?us-ascii?Q?VwUbROrihXdtxy67m1zTLCprc4GVkBN7mNFT+vWeD6H1a8GOsKfHbn/zBcPO?=
 =?us-ascii?Q?Wv1F09HLtHU6mz+W7utxbdQZ7LNGNlU1qGF8uxTUI94/BVQx/0LWGVTWOsKJ?=
 =?us-ascii?Q?zlmCB73SerMz3jkccHPR35pxa38Gh4NVQbahVdvDWhpsdtKWMNitaUt3S0Sl?=
 =?us-ascii?Q?SlLmeohayM2lqCap/oseLjZ4CE4yquBQ4eUkhyYuKwbZZ5Jk+WYto+ka415S?=
 =?us-ascii?Q?6XqUfirVSdui4mY4jQ0oLi6OkVpmoEaQxMXdpFle3rtz+U6PN4gWftssFsFR?=
 =?us-ascii?Q?pVTYpZuVmH13qphTHduyI+exI9FGLPbY9GQmCs89JFJuUUjPeaj4z2MHCiWj?=
 =?us-ascii?Q?Z+GNMcWDKztSHUD7PLsVYx38lcOVo4/VE5yNQjVN35YSlQ1muKY5JL8VVjFC?=
 =?us-ascii?Q?t+NoeeGApyFeJfa1fLvJxWlC0tVdyrWtWROoLywIGsugBXlflwTsRhdJe07B?=
 =?us-ascii?Q?jsV/gG+1cEWOdWVaLTOsT5OduVFqh9EofRC8LiYgogy02YsSelopzrz5viEm?=
 =?us-ascii?Q?1n1M8R7VyDR23H2yDuHYDX/7II6MIIs/jUiOBdUbmUcLwpo76qwWkcBCSBOJ?=
 =?us-ascii?Q?VgXnBYL0bXApkKY1hUxhsGPFNg1zUXSRUYlqmFaW/YulWw/X9gEWRqHn5xbS?=
 =?us-ascii?Q?0SpaY9CJNVhq9ONztzAh5jgNzCE2iMoEGfUDDTiwpgeJoo/kszkBrbSSnECu?=
 =?us-ascii?Q?DbKNpn5itrm4NGhDMUDk/KMAW5I6eGg5AhxSE/RmdYApYyKopG7zMQ5t85Af?=
 =?us-ascii?Q?/OqycyfAoWYn1+6ej/wpyq2e5XRlj9CDWhLH6XJ81ibIT899CjGyzpx2bWhC?=
 =?us-ascii?Q?xAby6Zhd4H2WgDq+Qyul581KT5Ah6Th2rPN9YdFUL1L6fVNfBAk+5pp6UqEj?=
 =?us-ascii?Q?tKxmJt6Qz4UoiykeIToteuiGaBfUWBH8TzFvrR+1Rr9xd1hql0Wtegyna81F?=
 =?us-ascii?Q?yhHE+PhbbRmClDBod9JslwCOIC70WhGd6r5EmZ7UhOJruSIwwpY5KEzzXfBJ?=
 =?us-ascii?Q?q4proWaQgPXPL2D0RGaolIF9Y9I5fgYjdKIDq0WfqtVFn1cWbNBiYkzJfMpy?=
 =?us-ascii?Q?n5OQD8IQwxKpnihbKTgkPPSL/VvJmnzvn8FcXK8ZLftHf4qodi9LxpgcKLqA?=
 =?us-ascii?Q?lRw5TIsNIT7wkl4Sk6pkWWA7hSAdz8ujxybNujp9CphFildjQpT1+GHgVzy1?=
 =?us-ascii?Q?IUUuE82ayvwqv8Oyzt6lb+6fpymLcsif1YON/cOYcA/DCqbqRfqy6emRQKFa?=
 =?us-ascii?Q?7Gpajdpa6H8X4EfGTY6sCGaM/3lRlXl0i4lUZgFDORARF8j7wj6jCsBBbaea?=
 =?us-ascii?Q?Pkg7thJOkKPmV7/+4cQaI5JX4RkL8NMHX7vs8gfZIvYWkV1ypZrqy8QYq57t?=
 =?us-ascii?Q?kPgsyzhGJPK7AYNUQtLkakP/yGHdYHx1/1L9QCOm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907f9ef4-a156-453b-ee6a-08db2c119a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:43:51.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9ZSJ0T0WRmH3fqhMpO7dmpmL0zNcr/vjgUZbSaeCXPxfaQ6jzebLnRVzHGkI+qpKdIdcLVSbBkVQlB9yReUbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 23, 2023 4:08 AM
>=20
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code. Decouple mm code from IOASID.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
