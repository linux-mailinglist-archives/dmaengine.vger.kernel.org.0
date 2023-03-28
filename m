Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4F6CB3A9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjC1CQR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1CQQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 22:16:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D026BD;
        Mon, 27 Mar 2023 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679969766; x=1711505766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1JnkT/J2ob6NJiRM4N2X4DLYXwxI5i35YBKpyJKP3Oo=;
  b=LivyNJLLnUi6EgwC5hN1bqVdzQMqNuNA4Eue4Z9eBXU7zTrykzYr9JWG
   eTP7nA0uGfv2tm85DyjMWNwbEDsFWI2KPixObbsgtlLOvwknh+BQPatJa
   /YuWRitk5FKnqZ12ItZLZonkUUZmmhvSPovzqzyBwCGYbAMEk1nLwrfaQ
   6aJetODiqR+FYUeJFexFxkHyacYCSb/qdn8pXTn+qjEUV1Wmulii83qm4
   pY1ebgxT6k7YC/dwPtxzlSXGl5SUw9lIh2Mj0TA3HJ0Pzsk6ANh/kHpDS
   42m0axtnH53HDSYOBp2frnsYtHJwUpRyfpYBhhWk7DvM6/V1gGvFtCQ6t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405384041"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="405384041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827280821"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="827280821"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 19:11:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:11:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKJxyKYSbNuQ74KN+fF3ZQH8aR+ZRYhrAYeas8OJJ1s4DpZ7YE+VfsBTCX0RFcY26RL09F1iE+xZ8+f1Ri4Q8uLKnAwT/ouX4upMH+Swfe20K/+YLiTLdEQxLXa9oi24exn1M61w1g73Z/v8bvAWhMeuZLei/mXHyLceGLz0BTVYGdtAqEzvXu63s4ntzlwRz0+t0j+Us4fBSXhQJa0oewIuT6hBCviDDUUroVfdIsD1f/QJm5/eLsw3OLpDjge484Ivt2/WGuSUYtEK2ZjrngW1607/nuKs2Zm5vhP6hgmH8GAeb5OWdPStAXts1xkNMikokgeobcE54m4dtgJONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JnkT/J2ob6NJiRM4N2X4DLYXwxI5i35YBKpyJKP3Oo=;
 b=moWjO9xupFiXkIBSaYJGBzgeQFnd0+FrTVEM6OitEvm4X2bBU/DTQR75T05wC+VhUB4Vw1lWzQ8evl57Uj3EwohhSofjZRqRIZQDJ3OaFIdGpz5d7i3J6hvYaeXfAqWHdz7eEC1UJqqvKHxbpVsjiAJ2OVK0O/c3QitLLWSh4XtQUaw9Kr9of0ERJk8oSx3ji0mWbxX6gjPkanXKNXbeTFlxRRPrGp5yYr9TbJqrfJqH6vc7uridx8Cx0tfV102Ro6BP1cvI6qfYvvZFi7T9da2tIMSKSNRPzgw1pKJgiZ3lblZXPqBYDSS32wIVy/tv4fKq2i37yn75BOTzxFBf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 02:11:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 02:11:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] iommu/vt-d: Remove unnecessary checks in iopf
 disabling path
Thread-Topic: [PATCH v3 6/6] iommu/vt-d: Remove unnecessary checks in iopf
 disabling path
Thread-Index: AQHZXkiN6RW9RnA21UqhUY/nYgdm668PeJcQ
Date:   Tue, 28 Mar 2023 02:11:46 +0000
Message-ID: <BN9PR11MB52765ACD4408975FBB7EC4A78C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-7-baolu.lu@linux.intel.com>
In-Reply-To: <20230324120234.313643-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5460:EE_
x-ms-office365-filtering-correlation-id: 6c903d89-ff81-4514-1f0c-08db2f31c83d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTiHdx/meO8JO7es5bm+ktpjelRUSIXw4iRZqJCwedpT1n/FVtUJkXep7NGuC/TOIQ0shhb1es9DRvZLjKFzVgKquEE7LOyNXH6yqIlVrWoAXSiU2CLp9wL0tLkaFL7nETyrt1rbbvzoWftv6FD/NY973nlEqwwvSYXWHeovIJX+qbWQQo6uzrGoxIouhEAHGQ3CAWfe8BhjTE34mS+Jn60InM/wfSjaDWg/qWR1LI3Zi/U366tHP5y1m443wykIOYM48joEF/Hm602o0D/fIoMVkwa+YmDaF52N/WPhiEnkimsELwAFJuVNidCOqihhmJ4kuNLusshQzVA6pN9XB1jEKPVF7l6L3fi3ohB/69qtuszS3qKKvvD5/ICkemMlAXL69hSKnVKnyl33aFaDSUGo/tkOJI9V7QdvVHd0efBvqi8W3EUoeRamn0H5btqRvSEWePHCyinIVmL+fO2ywOOuLrgtgPTeWqlEEI/3nsYqfx5QbrC4cpGMJJ9vLNcICxfAmTKcNE3+dazq/pR8oMDVyhwWNw8cANbg8N/Q2RhJEkPt1rTiqCw10P2yW5b6yB8/ORrTa9QCvn6+qhQpQJMLFUqYKdpvRw6fDQFPa1EytvkMgvNltkTVbR0Vz/XQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(478600001)(86362001)(38070700005)(33656002)(2906002)(71200400001)(7696005)(55016003)(9686003)(38100700002)(110136005)(4326008)(66946007)(76116006)(8936002)(316002)(8676002)(66556008)(64756008)(66446008)(66476007)(83380400001)(5660300002)(26005)(82960400001)(122000001)(186003)(6506007)(41300700001)(54906003)(52536014)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3rWgQJdwQSdN7zzgpKASOnma3oPpeh/RVZoyVIcTUJIPQTUEREDNKiA11Hp+?=
 =?us-ascii?Q?SyGSFofzUHuw8ef2RJTFqQ+LHSIXTdJUdUS+IYdjGbtgLnFEM/jGfE2Q6XOo?=
 =?us-ascii?Q?E605TdKUMdHYLuhHdb4E0HpPwF+JUfL3M70p6OxZxlkOjgYXBm/0yKTX/ql1?=
 =?us-ascii?Q?NHt2Stp7CgqNcK6KJPcBBQvIea5uroQev4qHA6V3V7L6NTZYfaqaQ63WLt99?=
 =?us-ascii?Q?eJhrPCUYi889Re0hSVR0oGyIh4sA94lAZE/CzGQgJKfpZMyLSxiI99Q2xuFu?=
 =?us-ascii?Q?0jJst/TAWLzDPTTjtZiMDrNP6mVCCiZ6rZQfq0+j89IQwG4FWmleuKPM6f5Z?=
 =?us-ascii?Q?o32uEgQD7Hihczn3awBHIDJoCC7xDEHTMbE8oLcOxYfII/IBzkfJ8kOYkWoZ?=
 =?us-ascii?Q?gLh574j7TJ8zmefK3Dj13TrpIc2upQ/nR+g6PsokYzvuuQGuKWqxzkpIpCFa?=
 =?us-ascii?Q?XTd2dKgC/oFKK8C2oBvSvtGofhnW5gVuDY8wDFlwl4Mx8FFjfD7jvH+S2mOF?=
 =?us-ascii?Q?hr3YkUZuChsovRd1x0q7h95QIPFrzZLzjAN/Xa+uCnzq7efuvTowKhJyGz7v?=
 =?us-ascii?Q?QlTaR0wPW4Vgi8YmOLuYRCZiasZ3yFXmu85trnqwPBOV46MCPykyzgvWSWQL?=
 =?us-ascii?Q?ihz6ZsUE3B2/MsnRMmPK5IUdDf5XGoH76k+oZchJrkML7M8uloqGOHtCVqtS?=
 =?us-ascii?Q?I8F97YPavcbiIjTjgrktcE95Ri+W6qPuSx0F25e5vDvm3b9HtN2ljKBOlxBq?=
 =?us-ascii?Q?xFRDSV5Yn22lLHtUu2B7n3TqAvm58AH+IH56KPc0kpuRMXj7Vm+HTuk7p5GI?=
 =?us-ascii?Q?1bv3UNv8NkKXKMSkL6DQeTf8mts0dPmDLeOGgzxiy61EZAiXcjTUn4tKqDin?=
 =?us-ascii?Q?JxyeDStVXRyZAn9otS7XfRVmoOggOKHzW0rr1rUon8nqBgeb17Bv9krOvGN0?=
 =?us-ascii?Q?UxfBCQgkKClDH74k4lQrTXVnJWF53nJUleaOQDnRWmi71BABVPBt3QLPhfde?=
 =?us-ascii?Q?Y/Qy4GFWWICc6UkeMfjeRQbee0oT03+PeZd7/zdY3yyfyAaGUbIfSQYSLANO?=
 =?us-ascii?Q?mivMe+IdcYj9IBfKIgQnJRq+pyVQOCqQojahelf4sWTIq2g/S9eouKGH1rrz?=
 =?us-ascii?Q?A96mp7JRxfuglSrPy3+hknRWV4lcwNSS2YG3Lm9s/iZuzkCiTwbBYW3riSpO?=
 =?us-ascii?Q?5qk8Fz6qSa14uNX8q97DPiL+hGTt++yxkj72ao4DNxQdcu2Nwe675VHgUTZo?=
 =?us-ascii?Q?i9CF9b29B67hy/JW9tE+xtqIiTBm2NRtjTc6y87lhCOF7Z8K/WoqdjVEdUnr?=
 =?us-ascii?Q?HBpiPpaPOKn2WeliuF0nmOjXbJXq2EwxeOfEkl9hs0NTVKR0V5qvNaZmYJC+?=
 =?us-ascii?Q?CWtO/PxMEbpHobgCeL5RKWD7ocHrbajIxcxx2wp83h++DFNMQUnn7Hzbras7?=
 =?us-ascii?Q?2GlErb2oea1SkMyIUrJ9GOGKeF3rYO/BKHMorjFf/sBX75AZbv6eKsYSxy3X?=
 =?us-ascii?Q?RhajApF4vR7riDBAdcwcjvsrAP6rWNJHCloy0FwFi/UFG8TdnPqzgiWJ9z0a?=
 =?us-ascii?Q?yiPwKJWKfVmsZaS9PPWq8aXkPn0ffLRSOClWiGyF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c903d89-ff81-4514-1f0c-08db2f31c83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:11:46.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tve0Fdv0/Jak5V2QqWLn79NK6luWQ+4YUpa6BUJI/fyQPY/jzVGdYjvb0N7efeqz3/ykKM2xJkslvDx4/Q8U7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, March 24, 2023 8:03 PM
>=20
> iommu_unregister_device_fault_handler() and iopf_queue_remove_device()
> are called after device has stopped issuing new page falut requests and
> all outstanding page requests have been drained. They should never fail.
> Trigger a warning if it happens unfortunately.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
