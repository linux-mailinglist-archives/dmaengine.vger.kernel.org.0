Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C696772F78F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbjFNIQK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbjFNIQJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 04:16:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AE173E;
        Wed, 14 Jun 2023 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730567; x=1718266567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2TPAVlWA7dOj5ru9kdfVtCgPLYJvIYxTJWdhGgzRB7E=;
  b=F0EjipovKbDl8WPPKQbnjGikyD1wmNn9quwaP146ep+Y0wgnI973RC7D
   RPLkyyeqIglRe/ASDz51NBo83KLBpyR7VtMS8h7xbpH8dSBBbNg4t00gJ
   9bnuIB6j/OGxnK99EmtwTGRxgYYGUTpOMYz89NLtXkM3WAOSboojmMe67
   X+gKtS3XeONiYNAWB3zKWTcg5ghcezeLxBqdlFOzOKg0ENmC05TyCLt6u
   6YK0uH0r846X29mAMJ54oMlIUAvqGF5ZbwRykLgzf7CFT/E7Kaq+iC0Ar
   YPT7JFtLluQQNosqHmJKT3EanwLoixhW3jdA92DiR1uDjq3qMzWfVEBjc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348214978"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348214978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="777145333"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="777145333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2023 01:16:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:16:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:16:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyuQrsi21oS6YY+JXqGSbp4OXKfgOvhROm/tuoorsqECxx/A/L2bllw0nwyBNhKsOr9l3NedFro2ZP0b69AOBjVWobwKQh//mmKvhT9ubY63nv4gg3OOH0uOXPh9aAZulXjSJwOdebzeJoBYnWK6srcm09HckaBFdpd/dm8NNZYi0hRi8zhu58doevxOCwoRWZMQTt4J9n0qs0ujDuMb/Zb8Xr5w0NtzqYWIID6AoybMnlRS65hwh6ORXn5Ae2OPCS9EdlZC4Te5DeMD9D3Lwl2v0X9CGRLi0yMEbO/YTkrONUOqhfA81IdgHesVymWIV+TlRu0y3TJVGcRC3cX1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TPAVlWA7dOj5ru9kdfVtCgPLYJvIYxTJWdhGgzRB7E=;
 b=as2wvNfUOq9Ts3icw5lQR7InLNIFoejHuYxPVYod6ght/WV9af6l/OhtIiLr7p5APJZhj/FVgwPqVhNr0snJTPE+bx2KNoK6vvaygr0YFgtQGj+sD/nF73xeUTUcx2vzKJvmNtCBkicYMU1Iug2gmB3kV5Iu3ioLU9fix4So3CqYdTeHe89nW4nT+EQAo+IXJaqyIniJWpIrhpr8jUQwbljNGHMwH7kOGllHj5gkspnNMXs0FXF3q3nQZIXpMIJdQOk/DCWCnngKb4k6ZVqZ3FpLoCJeeTYHcV2vckFribUOONeyxVcxv3Ri3mSPerjIMizC142k1v3A12CAEzEwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 08:16:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 08:16:01 +0000
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
Subject: RE: [PATCH v8 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Topic: [PATCH v8 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Index: AQHZlX6G58yoJ2trREy+k2y4ofsqpa+KBcdw
Date:   Wed, 14 Jun 2023 08:16:01 +0000
Message-ID: <BN9PR11MB52761AA7A9D1CED09E7D31408C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
 <20230602182212.150825-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230602182212.150825-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7889:EE_
x-ms-office365-filtering-correlation-id: 552c0aee-c7e7-467a-0bde-08db6caf9713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ys+O0ZvO9OvAfLYqFFEx0MQCPiS57jtojMIt7gIxQKlDJEsTO0ONdRLyDAZPuRRFdBTHXAYxUgVTUW2aw2qYx739mLy2V+AnyHKabTpyaq000V7chkYtAqstk4A3ue3pmL7KUwFUzU+rnwDlzDEb242dcpiV6uGqHVD7TDjk/wUzpO07as/ab3zWSWGEaXMYIMhm8nFfuuBxV8F6daEP+Rnh1/wgRSt6JJcdkCdwZDttqRlwEoT+QO0ZmzceaN8DY8Bq2GyjYrOmL01zTKtaMI8NVEplEvY+RaKhWIcI/1UR8+bv2bCGZI8gCifg0joWKoZX6WptRcF4459rjApS7QGYwQ4hreNkST7zEDD8MAoq0+ZTGbVyXxUKoY88JtV24pl4z9c7Mh71BA1J37Wk8LdOxOds9HQnmXS09E/thuq92M1AWH3CSCEZc0l+wYnuJpvAi75/i4BRwXAIVW+0w+453PZC+uFsr13/hhzY3n+9UXL8MWS73w6YaeKkmMxbn13fub60ZURTf3ukVxH8ysGEpJxLTQAwOoI7cu4u7blQy79YOuF+v0uyhPzihSbInFIr0Fy0X1AgPjhIHap/EJXKChNKA40dML/FYd2dy2v6Ld8KubGMpRdJGkiOiacdG/yfoEoVhsF9zK+hbyvDMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(921005)(122000001)(82960400001)(38100700002)(86362001)(55016003)(33656002)(38070700005)(7696005)(2906002)(4744005)(71200400001)(186003)(26005)(9686003)(6506007)(316002)(66946007)(76116006)(64756008)(4326008)(66556008)(66446008)(66476007)(5660300002)(8676002)(478600001)(41300700001)(8936002)(52536014)(7416002)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLHjOCVmEcXpPjB+03QQgZ8l7T6UyM2//cBcxxlDiqIAbhih9znk6psk/Pl4?=
 =?us-ascii?Q?5+ZYCQr5q9hH06v/XnX0vX404W+sY0DSdScHQwxfcUeebl/bIBSgS7/FrJ7i?=
 =?us-ascii?Q?ViqB5+fe8foNdjOq86XMxEmWWcufHH1Z1U2ouKIHe4gn2jQwji5grXnmlHht?=
 =?us-ascii?Q?cJsrbKBx717VL3p76tHLSkWqFNhmco0uma8jN9MQL5i3qBgzK0xB2Kq9sN7J?=
 =?us-ascii?Q?mWaIiSu4JhmltRah1lgj2UMFaouCQ4oViW6DS3Gn0Kh5Zc8JxyECLj/QCmRm?=
 =?us-ascii?Q?x5J+8QuLwBSA7UR5HnkiJiXrdncSrFhMUJJp7khPNq3FlSQMyLsYycSKpZ8A?=
 =?us-ascii?Q?DBOw0g9QLSe9S9GiRk/YwmjhxIe41N/fARwWpwBUdECcYEpaOHAX68BOcGMD?=
 =?us-ascii?Q?2MzYJerGdloaiHD96vdUVtYamjf2bqnXahZRWRyymXK6AJLsl5H8ESmsUF4h?=
 =?us-ascii?Q?9EC8i6ZuCyVxZABoY4btVICUW2EE0aPk3i7sjra6TKyFbYMtp9rphNeu/Gat?=
 =?us-ascii?Q?bj2QLTH9B5KuZ+Ip8Z8xxxbaqDXnBVrGtTygrgdW2qT/ugKtVgjPhLN+fFNs?=
 =?us-ascii?Q?Bm4FwtzG/kJyOkkZT8fgwXJeFLwmMudSb0G/EDktBRFEAaTx7bvLLoP4QW9c?=
 =?us-ascii?Q?+YcdbVXppaW/ypfOzLh7SSNX5nTwPFmZl93X6GDH0YnygS5P6CIC6AqWPhQM?=
 =?us-ascii?Q?n8SahZEFZOqdvqDInABVGTVUQ5nNINnOK9/lao6vxBgtY8gjxKrHY0dU40Qb?=
 =?us-ascii?Q?Pm1zxMhIpAFNSQCOmrDl7CB3QdrFH8O7VFjIq0wqYgDmjWucjL5H86/pGmcJ?=
 =?us-ascii?Q?mvCGN7NK0UApkOrqnRFFdRRURv3/NHalB71DmcbbLL29Ar7j/ezo24CfU/BJ?=
 =?us-ascii?Q?fpE+3PWeYPPBi1PJo3IDp14kShd1U6gUCgXdROIFdAC1xCCTzvn255zZ/D8U?=
 =?us-ascii?Q?kMp6KntfkOM4UkuuQa8gqhqkkbeaaktsA2mwiLgebCNyrmwPLlfXGs3nac4M?=
 =?us-ascii?Q?17Lq8NOERlbujp4N48yzttC9adwQk7xAHg46c9cEMN/qYi82FWiTaT5mvcSz?=
 =?us-ascii?Q?/qj1Ufsb7cbdtaajjJ+FlAnACQ0/S4zAJKA56IxsoppZPQAMW16PkcvQtlGC?=
 =?us-ascii?Q?T1YuFLPAKV30QJvbZZMjwwoQ58g3hZADZtmZ/zsDZdoOYJCFa/jrAfOKJxNI?=
 =?us-ascii?Q?/IZGrqP8FMdEznh4lG5UKYYbZHPdYfufoXzpUcIu0DuHSAZvi+Yw0mHaHxil?=
 =?us-ascii?Q?R5oqAQiaV9vn9hHOpE5XAzlAZWX5El5tsmTXEu++b+95WG2CaF6XQ79TvPMs?=
 =?us-ascii?Q?1BGP84bbNMM/B5GH3elFKOgLZNEKiEogmXboo7KTzFaA1BixOeLY2UC0Q+FW?=
 =?us-ascii?Q?IVJ5VaOXIKumnR6xrPfC912/f3XXZvzHyyiMGxdnQNSaojBj1T673r9EE79E?=
 =?us-ascii?Q?lrF2HPYW6qKQ9c+jdsrDHtqIiuMqxKs10gxUBcSRt1g1oT9vmshYPzV2iJwS?=
 =?us-ascii?Q?FoElDEB/5zLIoIBwTzI25hDDP0k+ETDXaCUUxOkP6rfC/Y5aKm4Y12NRTbFb?=
 =?us-ascii?Q?KgGfe1VSo+sAyD8OSQe3spiK+LlEtnwatCgWoM4X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552c0aee-c7e7-467a-0bde-08db6caf9713
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:16:01.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moVB6xnwj2K5nM/bgiHyCeaB9Be0MQlst+Fdpx+9j3cJrVA9OFw7DjG3IPUnIXF8UMv+VCHOXq5JKat/41gwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> The VT-d spec requires to use PASID-based-IOTLB invalidation descriptor
> to invalidate IOTLB and the paging-structure caches for a first-stage
> page table. Add a generic helper to do this.
>=20
> RID2PASID is used if the domain has been attached to a physical device,
> otherwise real PASIDs that the domain has been attached to will be used.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
