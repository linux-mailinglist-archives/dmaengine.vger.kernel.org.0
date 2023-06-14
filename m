Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654F72F79B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjFNISR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbjFNISM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 04:18:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D21BF8;
        Wed, 14 Jun 2023 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730691; x=1718266691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wMWlDl9aXG3CF122rRMjo8QVfiwMPNAlWspYgZ3W44=;
  b=HlrOOqsBJodGGVNfa7YDNlnm27B4vX6tcj8VxbqwPsxcChv1RiaV4ZBt
   ZMNYYd2OIkw6+GysqNq/WrRGFePJGQzq8Lo7m0BArPHPYaww+DSIhSODL
   905P3PnmHLUUG8pC7SK8ITJquNmLaj9A/3KhiqGPeGfEoTarMiUOIDXlN
   UtU2qp7Y4AI8JLsF8SW8HyurusiwXkU4M/5sSRqdU5IcSCJVF+5KTGGFC
   Ne7xUlrYfqpcXoggsGp9ucnSbD9a7uvylmQUM5q+ksrJGBAE+evEULaYX
   ec3VlZkvMrEzvETCw8eiWOZnWUujIHGltJXE8MK85zxwkDVcWDp0FV9+O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338905864"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="338905864"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801822274"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="801822274"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2023 01:18:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:18:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:18:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:18:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOOgyLeVX9L0kEyENlAkiRkVFaqgrAcHgU5jlRkWqfWQbv/DkqRKE8VUWwBiZ05iemy6AqicsHsJ2GsVKC1ZMoN63ii8DhMJ6l5CeflIGIfiFvRLuMHZ/yHs3c9HiPPRPqv5OO65HbgalHZ7hwOwIRwv8zaN12++sbvaTw0TkaU6+XYpNPG8qj2hEy8B+oUwgzaVXeolsePbsYj4aHZYQf5Xoe87xFtljNBl6KQ03SmHz/v+GwxI6d5Zje7sUSsXhVeRV3d7G/K18bhjYKmpHXqAY9nSToTV82wo/JNcbVlf56WrZS/7FUVHMZcjqG1NNPT940bVSz8IcnGyvDok+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wMWlDl9aXG3CF122rRMjo8QVfiwMPNAlWspYgZ3W44=;
 b=MWkbfo5wI8NvgmdDmVzFsGSolidQKotitJH7aqSY/7o+LUI2CPWkCxfwlwvw0etO6IxgtH7S6CjM/CcLM1KT0WTaLDHIsVDTqwaWDGq/Avnx47C28AnSuRS7CpeYbU7YnQQ6Q1AQpRQZtrRFVD812iUZa6LN/8XfQysUfm22FfjoSgljunSNhSDkvVnTeticTXqSJ3x2Hlw47dqjqVoH1rqTxYVOrsWFF9nR3vAkA9oIX+4p5p7kUWs3mn6dT/iLwFEDIU85y/6CmjtYHPxYg4snrncawnkaIVXtUWtbgE4vgRwBT1r1Lk4lZHN8v6cSbWuyyw3zothisAK+Cm64Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 08:18:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 08:18:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Zhang, Rex" <rex.zhang@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v8 4/7] iommu/vt-d: Remove pasid_mutex
Thread-Topic: [PATCH v8 4/7] iommu/vt-d: Remove pasid_mutex
Thread-Index: AQHZlX6IuvrvWQ2rqESqVCpn+rp216+KBmbg
Date:   Wed, 14 Jun 2023 08:18:01 +0000
Message-ID: <BN9PR11MB527656125EF570DDE2AE1D9A8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
 <20230602182212.150825-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230602182212.150825-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7889:EE_
x-ms-office365-filtering-correlation-id: ab44f37c-9fd6-4f1a-e0b9-08db6cafdeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cu0l+4b6zk4gvKuG1UPwCwhrmNCIv5s1zNHS8CUBgM2bfQxEEpBL+MQvPUdEzTv+bS+/4dafZG+Mb3dn7S5ishGzqdC/P1D9cI1J3u1qwBfS/LUk72u2WiYWHotZQksioSFOrjH6oOWmSET8Frvp2Yc+SeL+nnoinAaaDz+o7Q5eP5CYnUuN3nZvRhhmFcYdzFzdWcWC4PNj4jTnIzgz1kMu5Wt9De74apuVh32ziyFrgBH25lPme4xRGFApulyWGvD+HeT6Bz9XVfBaqf6bCUX5lcYC41TtlKqBD86IYdibDDdwWQXMGz7U8S5ATUbAOqSvSliehHVogrWX4nM3ZMRS0+6wixIJdpfiI1ZQjcthknJ/s5Y4DyGup3MRrEurQefUb3w9N6y8Emn8FVPoVGcoCGMSBo0hDKOGx0gnc1UHiTj+XJCNR16J/L+JIXq/qWZXeRvdSW6z9qFzNGWE4gwe7nzRaVrllzEUJrzi1SWl871Y7PXisxFZV3+h/2Vjzju/5gToB7qU8b2KmE+8YPk4g7whNy4j9dA+uf1SBbmYobnMoBbiIdpxBQPgolOxirRbNG6a1JWUokIXA4jLYDLV0rkEHGaheK5/Ss1JMdQIlN84Hu5SbF9LPGI+nJ798yYDUr/wqG0YzlXDWHGWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(4326008)(316002)(52536014)(7416002)(478600001)(8676002)(5660300002)(8936002)(41300700001)(71200400001)(2906002)(7696005)(4744005)(26005)(9686003)(6506007)(186003)(83380400001)(110136005)(54906003)(38100700002)(86362001)(122000001)(82960400001)(921005)(38070700005)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3Ci93YAVcFsLOos35JFLPseYQXNVc6VmP56RouFON6Gjnov0E26gWoAigxA?=
 =?us-ascii?Q?j0k+A2nT9hQV2U9V1GnWPgLrkWbRBSx/NYxdykRiv1Q2toxZriMu3jbofPOl?=
 =?us-ascii?Q?1QCkBONvlia/6bd07xBHprtAKP05qEHooDon0zQkxorui/WT52eP6odHnqgg?=
 =?us-ascii?Q?rpah/Dv6xMcdqBuwNR2BjYCS7LgJQN/lr4rEBmhpHo6uQcfRU6rFtj27JNxq?=
 =?us-ascii?Q?B5BtF5q3sYDs0liZR6pBPJiHtclP4wg0rZS9lu1ZxVjRVYQJVFI3KX139RJQ?=
 =?us-ascii?Q?9XKUKGtB6l9S8orRCQajoyTfQQsFS+alcjTyqEBwY+IqVmoI3//QnCSqst6v?=
 =?us-ascii?Q?M4zmH/OkbsnuZor96N0LI2MdAyJS0oPlk7Tygo2E6wQR29b89MtltQzr8JsJ?=
 =?us-ascii?Q?Z26vJdj6w2Ai6IwhjFflJxfWiVnScR8axIewIst5unAiZBtjL7A567FcQAjH?=
 =?us-ascii?Q?GP+SNocLigWPhozg0n5EKFAGIrgSIc9nBpeVq+xb/fjDVEI3MT7E/fOVCiSb?=
 =?us-ascii?Q?0W4CfcX+nqCXGVIGHAeAQzCPw0FmUZQCYc+YUX886zFgT4cpZAWZIyvSz/PA?=
 =?us-ascii?Q?6IBEn34PqpPFHsN7jxpCIxZn/i+LskIyRnD4qga3kvyK8WaXfGtj4JHJmT8a?=
 =?us-ascii?Q?OSFItO4rNZ7MuPirm1GqoDFGiIYaSsNNSnKsgIh/k+qirgR1ScvOYEfmLNuG?=
 =?us-ascii?Q?3o/WWKTgNKhpPfDeagp+3mjM65NDNEdpiRnFmw5l6CBYh+Ui5gx+9SoTi5Be?=
 =?us-ascii?Q?B6m7rWIMSSb30xBs94yjyhCwHanUR+r/rSpWVTBA21nl6+DscRvTNhN9n0ut?=
 =?us-ascii?Q?A8uZxBHhrw42U8iqB0jmTLAZxSKKGpKc6yE5yy5aFkWbEUE2E5GEn3DMoPF7?=
 =?us-ascii?Q?lMwP1worHY5osB0Plz6CiplfssfT+hlACT1nxBnnKG2RZodshvxksykDdEjC?=
 =?us-ascii?Q?HKlTUt9LmMPn4u0oj+AnagbooEf++cTLqhSYVLvxYQHF9eXJDdjIoqU3u17L?=
 =?us-ascii?Q?Y6B/QsorPigzd4wgxBdn5aLOuvAiUUhxZAhdMkKQZdn+ti8aXk4C1TN/T59d?=
 =?us-ascii?Q?PKnZ+MyJoLTMLg2dP6ZVC+nYwxYQcy7+VecY4J7nZ1vZVQC8f3j8b5EFi83L?=
 =?us-ascii?Q?UC5G/QtWeUeZ1xRKfqMJbhiKkLGEuqLdnCYz2cUrcm2XGWx6d5li2n/n7tF1?=
 =?us-ascii?Q?8fROVqXBQbGHpVocm+N1gXPxAapa69YtgtKlaiBAO49YkAkmVCovFmdnjirE?=
 =?us-ascii?Q?IXtQEfau86CMbuNd8ynkODis39kqYnw/KkmXkCtjkJi6LtdDlHem2YSYmnem?=
 =?us-ascii?Q?lD7srpBCjybAbvhQxisRxZdmq/jcywv3Fjrzp+Qbbnste85Z8AsUSYr1FuKd?=
 =?us-ascii?Q?+yEq9BBlBkRYMV5/nmCUUjXceoQHiczeHyqrT1kqdSP6MUHfIyw5tcGqTFIm?=
 =?us-ascii?Q?TWiYuyFgidIikpjbLyTcYZaj0Yx8I4NShCkP/jIlgPGX+ZA5f3IO37w7p/8K?=
 =?us-ascii?Q?WjSwftof8GeEPEDWtwOv4TOio2PK5jZjQUHHtl7W1JGGJBcVh/2YgB4Ol4S+?=
 =?us-ascii?Q?EHkfTK+ulNW5v2K3geP8xpUUh7bWvu/2hZhANOH9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab44f37c-9fd6-4f1a-e0b9-08db6cafdeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:18:01.7670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYvRYQYJFN0TRCPa/Jgp4+6Y80R48bJu2BIURtArkTnPvYCSA2ULV6O1DJVrwMns0w79o4ONpjUCrCfIZp+cLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, June 3, 2023 2:22 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
> It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.
>=20
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
