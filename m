Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B766CB3A5
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 04:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1CPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 22:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1CPt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 22:15:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87101171F;
        Mon, 27 Mar 2023 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679969748; x=1711505748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H1/dqv17AG3hp5tV7qbvcchxn8GLLGf9FMMmuJdF9GA=;
  b=g2gKEKIv9b1XPFIGaTLpZ5QCdrkR+O0wkofEabZ0kaC09qiJtnotXA4J
   1JE81x2HJtHVtfTPinm1aO5MIz/LXQjXpHo+kCJ+byvxW2Jn3HF7tl7Wd
   lhn4hPEAKebVkZxQsSyTkSSsgCEOSYAkrTuJLV5q7fhW34hcdpKAxCKgk
   NhTpGtaep/4w/NwkyPZNwxgsKhzqQP6bMuL3j3rP+pVyxh0YYT6w1kLYY
   gT2xtpy1EF7bIUM7dsVQExTNLHo8Ev0e9jXlvSeR/2mNK5zBQW3bBuVth
   x+Azo+fo6hg4/PZquYYVWVuT7Z9jKEDTc5IK8LtMwO2No02Vd7nIJ7JxY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342032794"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342032794"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857878551"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="857878551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 19:11:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:11:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrZSzpcvTSk7TIPqgT2HuNs2eDBt1Js9OgSeTnuNttdBAl3z0cUPWn696Y/p2YMCDgYKAKnGNLvyi6LjItuJOiCUbaWNizlXxIbIiiuP9s42Ii2JHFLna8Po412Bht5kOWwNwjAY19xckGxkjLvpz0faNwPx7t42bCMP3sb9ToYzfeBiwqCpIcd16ry7itmaWcYOSqhwFlkH6HKt7NZ8BxO99i0dW8vwv4hlkC9y4fgmcZgXTuWUPXmtgJD7W4TZjaPII9PRE8Nh0yVt8g+FvBQCMOlWMhraTBEKysV/1xul5lHH76fusIRKi+Xnu+hsAD7Qkz+ip/T43WNIYYIHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1/dqv17AG3hp5tV7qbvcchxn8GLLGf9FMMmuJdF9GA=;
 b=PZkGqR5VFc5jmrstNhGF3O5W5eQqCYkBm4j9toJW9Et2Pz5skjFsg3pxzwOVPQkqksvLhVOH/7ENMH3++KPs1RJ6r7K9DzJz4wx4na8N/Ai4WjyO+mAy9P1+sRNvTlao98gU3RPhSexXNP7cEJsbdaILjz9TlxVlfl/nay1UrqggSBgEbkPVfNA6+Iglefblw8OAojAeJSYxpggoaeTbkVVm5c9mVaoGe5vRRmjqvfvx0wGBUZvH9nmBIDrQMWBKgu9Wqj4pEnYynXEKbMzbzL+YlmTlxY8BMXUtfO2WPckgEZCSrypKm6NZYrOHxmhfWLWVwMkhR2Gr8Ey1Oj/Q8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 02:11:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 02:11:13 +0000
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
Subject: RE: [PATCH v3 5/6] iommu/vt-d: Move PRI handling to IOPF feature path
Thread-Topic: [PATCH v3 5/6] iommu/vt-d: Move PRI handling to IOPF feature
 path
Thread-Index: AQHZXkiLKU+cHgEHPkuHUBlw1ICwba8PeH/A
Date:   Tue, 28 Mar 2023 02:11:13 +0000
Message-ID: <BN9PR11MB5276F5F0B79E7F9453B9F6318C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-6-baolu.lu@linux.intel.com>
In-Reply-To: <20230324120234.313643-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6355:EE_
x-ms-office365-filtering-correlation-id: f53e67a5-f17e-48c0-9b40-08db2f31b492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vI6J0LM6UVs6/dFKP85hW4CNM6Qz05qLqvp7zoHDJzkV+BKbmGl+HSHmph9ixTaakqGO2c19uqN8aL98Mabl8denLk1nNY/aT8Z9PX5yrmyW5dFw7hFYmSuCxWRL3faqJzMv0Fp/hzCKbic+kEcUUU4dEHRWqzrB6jAq7jA4HtgKWOkUj3tyu0zcpJcbNwUbGphERPiC5uuFbcT1kKyOt3QmP/AkUuLOgAPhRA8rM3YaLbTDcg4ZiFCV1X49QiNnVJrzDmWFXOzwOa5k1Ugx8Y7xuUgDp4cg4cnZ4nt8++cu4Fjir1ZO1XLhiJ7u3NUynkTMesezvXbsKWoCXE6LSZSWCYizCcjdSixeqn3lPDO4rlDEFr/H2J6yjpUxxweO94r7SMUU5P6/1KNKsejhdaEaQsYk7ol73NzdrvI7drbJ3QCQVNqnxKB6FGtS+CXwO+lelKccu6Ootj7YtzjYt4xsk7kaUzLiEVfhVawuMIn2Ym9UldsauYyZ8NfETlVKLflDVYpK+W2q9o1AYM3662U1Q2jHuOHgVW//YstrVywoWAUUyXieD3+AlpDlmc5wOtFxU6+T9/4Ye+LsTg7jrE1uwX+DQzutq1R2jqx6b0ltpalD2k4fZHFZ4t9Exdsh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(71200400001)(9686003)(55016003)(122000001)(558084003)(7696005)(82960400001)(316002)(41300700001)(64756008)(66946007)(110136005)(52536014)(478600001)(54906003)(33656002)(4326008)(38070700005)(86362001)(6506007)(26005)(5660300002)(66446008)(2906002)(76116006)(186003)(8936002)(66556008)(66476007)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sitWbbQim52RopfUlxmoWzA0YlQEaysybrq2+fpwR1xicmAhscKm/EXXDc5P?=
 =?us-ascii?Q?cm+1aQkw1f8LG6s5YLHoYlemt0qepBscgbhFXLdwgupVpyn9sk9d3X4kEJyk?=
 =?us-ascii?Q?WMmLVZiFHMovzro1iZAe5bxXFTb4CXags9BhOA+rIQQFFgxDDkz9DfLlDx7J?=
 =?us-ascii?Q?/qEhWXko/wYsO81KDKHPvRCzLx7oGSzV2qGr0JRKIZK81+zljOkzKGILl3xh?=
 =?us-ascii?Q?PaGWyDWaF/1WP5ETZmK5GjkdSE3ZOBRIItxnrbP1OOWt755frA0dYWTDVEd9?=
 =?us-ascii?Q?Z1mVTwhqkd8yHUCG5qCteScfTHsEKVfoSY8b2klf7neHAthHPQvHIQt+E+E6?=
 =?us-ascii?Q?90B7OJkEORTCrfzcu6VfjdKh6xe4quTuwNVSIK+5DJuzNhFWOTnWDtgKNvEZ?=
 =?us-ascii?Q?4JgnumXR4rNvtFEz2MXsXaSbqxX700wXAbOhjt9MZ5dg+HdMoUUNmIqHOcY3?=
 =?us-ascii?Q?SqmmHwBM+fqo8m9pVli54vTkUv7uK86IBnGrQvoC9Ubwnc5e+sdo3cDLPXkR?=
 =?us-ascii?Q?EgfMH7XsbIirNQ7Ntt7c+11dD7mV+1AQBF8fC7RhOWFThUcUqMqNA4JtbdT9?=
 =?us-ascii?Q?C2kSk6WGv2SjC/0+6TQLDRkwQV71fioUMgk+QhDWs4Da4OH/bXNUjj7d8wb1?=
 =?us-ascii?Q?BuOMR5E+HwdLiR7dvtDmwJd3rvzQCRba1bke91Em/nvRVYdTWq2VQj7pER5f?=
 =?us-ascii?Q?NbKam7XSb1u7qhWTRiAngHevTZemHHedO8id0fmqHmtZkFDXnR4GDKKMAV/c?=
 =?us-ascii?Q?Voz5h1lOOr0qkcWAE4E0JyJyZOYR6jWbEVovAfuEw44K5h4zGv7Mppywuc3v?=
 =?us-ascii?Q?aCaOLzZGIaGWab45pTrAzANvhO1AFS80qJEIuSmueVEuf4BqX/TkeGcRXVYB?=
 =?us-ascii?Q?xFhnYmKkXTi7fn0EXJiuzpweJ6uYbU8xFpMF876SFHZRKA9D1dTwC0j8VT6K?=
 =?us-ascii?Q?29y9oECkNllhNExd0Kz7C+YmDUOA1f7rCfJGtZLQx51xXag/e0/zGq4JP3UM?=
 =?us-ascii?Q?eMK7UsyUhEO6ubUbkRM0M7qzPIt40MUAUy6vSgChoZdtnVaPYWMVbXHWFHj3?=
 =?us-ascii?Q?+04FZU+T0y+YNL/fUqjitDuvPHux6mvMaj0K7JKqkdN1fCnZHD7i6cP2F5jE?=
 =?us-ascii?Q?sB88Uq4nqu+1WWPR+/RXTTHyXcjBxbEV1RFnK82oRUP1Aw6zyA9FhsjnBEQp?=
 =?us-ascii?Q?Uspx35QZPjZexYtV0J0U6qkV2EpMVkkszRmwxgniP4Vk/Rh9UrMSXyEee28V?=
 =?us-ascii?Q?hIqoV6nQHAJesYk3SML/eOQYrd4Br5hS3Q0Kz/tDjpuapM7k/4AjtkekRgUU?=
 =?us-ascii?Q?jE19kvX+OIxBpaON2EWWuKxOKP9Iu50DsZiGlYFqdH0GsusSqXqkP1sNYYIi?=
 =?us-ascii?Q?xuq8c0Skbofj0ILVALb43VBUXv2VGO+nsAPj38RewO6N0e7VuVBG+k+hK1Kb?=
 =?us-ascii?Q?PKJRcGtkK5HOozYOBHOgwuDpyyU2chHjoy8NY3TMB1lDnGUBSzB/AfexQJK9?=
 =?us-ascii?Q?VoT5/M9fcmkl78MiThucUh+5W4/hkE77HdA9HPfohpOcJV3SczAnnWd40ZiB?=
 =?us-ascii?Q?UoQR85PQHdYMiwhs/DFRGjbeGPhyJZ7MyT0lVCkR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53e67a5-f17e-48c0-9b40-08db2f31b492
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:11:13.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVdWHSjnDAl4VH77IDX2bijCmfSzcyEvN1bUXZHij4tEjgUWrXkc3XwvzJ5YqDOpg6ayB347mtOHmfjdvohS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, March 24, 2023 8:03 PM
>=20
> PRI is only used for IOPF. With this move, the PCI/PRI feature could be
> controlled by the device driver through iommu_dev_enable/disable_feature(=
)
> interfaces.
>=20
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
