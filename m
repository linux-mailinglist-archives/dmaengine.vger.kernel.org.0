Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557036043C2
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiJSLsN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiJSLrn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 07:47:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3E916724C;
        Wed, 19 Oct 2022 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178819; x=1697714819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYvcYv4qIetfbf0GKCF3640hE1V+39glJh8F2SiEYGc=;
  b=V2o8VKRKTDBX7VRZJImJuBowaGeZeYcq/1QMIXj2lgwacFx4T0veBxAk
   GG7rs7/Vq6OSNScRd75qRPESqWFywKfoVM+wY0Uzg6+qzEDIPTKuBdPK5
   AQmXrH48ZDqGg/lTtTpWCR2ybVKi3hsGVTMFxj+tYYVVA9hnRHWvas3T+
   Q+vIP50sjIHlSfWhPbgEQWV4iqTLAZ2DkrBfJMM+tcI3aznnjs7bCwx24
   irnarMIeGNCJ0rpDHFAw36I49C6gYc6DuaQBEuUfa2YMJZqmnRmK6DGOD
   nHL+5htU1NxcVO8xcyavMHYNbFrABOlJtHYSjMbG0+LTMZcQUhghZtF29
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392664166"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392664166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="607011300"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="607011300"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 02:46:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 02:46:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 02:46:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 02:46:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 02:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hesTFV5MRLkqKrEz9MCHcw1IVmR14qndOm9CqLq2S+QC7bsvHhjlbH/k9dCzbUiX909UfbsSJxhtNR46a1k6eW1m8yazJunKuXOIxgDWOUzadDc7dKt7bqOrUMFXBlIelbt3V/VkKyQVxIfcw6l3tJ1qYhn3G/i9Yo0pkEWX49CPC/2NulUXxmn8qNFcu0SvWLhN19+MklfO4RKBa23fCeViR+kWZ63sTvFe7OdZCGmYarab5Y549X/YZ3WKNX11bte/7MAd4NpDtsbJoq150L8G9QPp9T7b1d1xTD19UHB4P/lLJ/bDygELvfwiZjKfwilb3686U2H/oHG6NiFpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCgyBKJ9d6lt4VQeRpDfp9Rsmn8Tl4jkhernxtel23E=;
 b=kxeZ9azrodkbFHYM+kq0eWPe0R/XLR0wFhSBWxTCiTmU4XqOAnYMfDs0d51OaSyLn5H+UBC0HyU7XGjuSryvsxfZL0kFTPjJHJxzWLKDN0ltY+z2+fgtPWjuTA5thBBmi7BxJzGeQYMPNqL+G3rk0fUnFmepn2MLRGacJr/70T2HnfjzlGVV15aQ+1LpT0Y5ypaB+WNnbkDzspK+ZqYDnlIwUboH8d/aV0Rf2ST9gis8KcLOAAHw42+dafvsoEtzZJNr5nLwor5IUA9v4ln7+E3hLOCFCCfNnSOJV+TCT/SaNI1piYqyxW0Zx+miFqzbQA/aN8S4/V3VpdzcKjS1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 09:46:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%4]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:46:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: idxd: Do not enable user type Work Queue
 without Shared Virtual Addressing
Thread-Topic: [PATCH v2] dmaengine: idxd: Do not enable user type Work Queue
 without Shared Virtual Addressing
Thread-Index: AQHY4Bvoj4lQIaJXwEmOKYS/HRkVUq4VeWOQ
Date:   Wed, 19 Oct 2022 09:46:15 +0000
Message-ID: <BN9PR11MB52767EC57A768298ED5084698C2B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221014222541.3912195-1-fenghua.yu@intel.com>
In-Reply-To: <20221014222541.3912195-1-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6828:EE_
x-ms-office365-filtering-correlation-id: 7c66e5ef-bf8e-45a4-7b70-08dab1b6c3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAJ8T3Pb2z7n3UqLtMnnb2vwgnPtQlA2VBzNANIw4V7JjJK/3NkU4Tzr+7MoofXDxDhHjiR6cl79MQzrXRQb7PxqROP9CtHalXthVcEZRlCDjQ1rZ6VlInNjzCug9qMBtE/WbIGJe6FcTBGefvRPUOtwKEYvgejdhPl23NnnV81IqTJy125kw6LP5XvcaUDI5/wtuKWdvxKqZ9eWwX5LBFA8mNwOuXn1pQ74ZVHLNA63VIgPIv1HIgBr8EXUiyszTOAUFGqImyPYQdHVrkFGUkm+CV6gyiT5uUy9c5sBay+J8f0aJKg1HT3chYQy23mnWx4/5xdgaNu38r0ST7t+9/5HJU5rTmxk9KbQh7tboMNPKs9P+cvQB1AW4CCivZpWa1MP3WrSbI26vNWf0Yj+9eF4wYwtFXYk/7oADYYbWI7h7aujlQCsnHqSOi+S3Xzb4Qme8o/f7XvXpE621jwrEbUtZtVu5yVgGaBNaLhj+0GfR30oGbQUuJSn6gWA7eCRKKoQdBC1vujTLr9HPE12GlfWGlqgL5J9Bx4N+y/PWmFiHh/zaT/b9bdJe51wlAQMjDqbppME3iqOQMUT3kF3Mex6EEelrD5cSPPAEsY21ThKf+n7X88ToQzLAgyekC8dIIaXIUe/C+vVRwEJ4IiBkLZeM2LuRWVfN3KUti329GzRedrJyBeQEORT7hs8OgjXhTPwq4UjU0CbEkaJbbvEVzaUA7j1gfShzdcUQkqC5vyS9cqBGKlxvJ0ydoL42aDY6eXlOsGH+WZbI/AagUFoQTKzZQms6cYFqJeNjgEAopM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(54906003)(86362001)(41300700001)(110136005)(8676002)(76116006)(66476007)(66446008)(7696005)(6506007)(316002)(5660300002)(4326008)(64756008)(55016003)(26005)(66556008)(9686003)(52536014)(83380400001)(8936002)(2906002)(82960400001)(186003)(33656002)(71200400001)(66946007)(38100700002)(478600001)(38070700005)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZvJuKIAmfAw9lfBiriRkQbgUKyLO38UMwpgPFhIg0hfSX1+U6sqLpQcBd4e0?=
 =?us-ascii?Q?eWg7APJXX7uVj7YKPQISIKtiF1ibees6+DDJpDNB+K+oIc02SSTufF4O5b8r?=
 =?us-ascii?Q?DdGNNy2F7SicKOOQK2gmyX8OnROkxyN0wMEr/3N6w2bsLD0drhHTPVfZzvEy?=
 =?us-ascii?Q?QKRh9R9Fqi9/+BWx7f/2rs409f8812GA2/GxAAIZ/k+nN94gPT+Opyvr8+hf?=
 =?us-ascii?Q?Ul0kJD+cwy/gF6YnCW90YICojxRN3aIMIo7GIDSOJwYX3o0KnNee4YRtN5bJ?=
 =?us-ascii?Q?Qa8pc99pDvZY34fSnjqlNpvkcYaCo1mXLKl3x1qzVsQ2zXt1lsUX2f58R0/A?=
 =?us-ascii?Q?CXoxi5WRwz9grrJ+uY/puGM5HxRaBoHBFGaYwbJbvd/FLtyxMqBeqIQhZV27?=
 =?us-ascii?Q?apDXX6xphbqIO0hQn50vm9RufjU2EdBHaJSlZX9Ut3f6UmkvKQ/n+sv02QEB?=
 =?us-ascii?Q?/JewDoXdOdDYOwz0x0uN5UJQpQUFI4dQsVkktyt/4cpoYinpYTPdfgmRq5nu?=
 =?us-ascii?Q?xMCbmL2Hv30ZZ092j6ugjWLYCzw3pTh92kZbpQ+8HBJjYj/yD7okG4K/6f9G?=
 =?us-ascii?Q?4fXFP0nSnkKl6OmRy/K4WMAiVP0MVX/DSqIHXufZcQbThYa5XycCW1BNRiwX?=
 =?us-ascii?Q?mWroJZWBNB0rIHpKKgOnfy4ClDwsgc7PcAdC8AQ5yiTpaTJidsxiOE5Tet/8?=
 =?us-ascii?Q?elY2OUX0T6f00fwWGNMiflB5ApxLLXlS2Ysx9O9JLKhfQ/6F2BgNBqtrMjxk?=
 =?us-ascii?Q?EFAQnn9BvjNp6WLHHDxjowvFG0j2w+BT2jz3wWRbwthLI0PCZ/DL7OLcL449?=
 =?us-ascii?Q?Q1qE7wuWx6NwlEbwgkwD+mIKwMZ7ymZySJRqc5BQ+7MtCm8rLGt+RUXQ4ZXH?=
 =?us-ascii?Q?k1FbKvxu/GzivfdtvQy82XCnXjRsQ/4xTJGpbwmWu5HznNBiLkdBd1k2H++C?=
 =?us-ascii?Q?e/GRF5WIfZSd1V2HEORqylBZ5VV6iF3KQgEXMiB9L/ZoK9EZ1i/WpW2++w5Z?=
 =?us-ascii?Q?Fy/6Bp0hMf6bH5EYqYFHM+ZixPiBvxklB/R8uDZjqzcLXMx8XJDTkm8iYtGg?=
 =?us-ascii?Q?NlVjkiBBvnQc4jUMufH0zI8GGotdH1V8IJEfXr191k0kjHRiehBBQnVzLNPi?=
 =?us-ascii?Q?ZT7ySKKDqWL8/6q6T8c4FQLKzjnVaDWkcsbFQWnU8h2WMyt0r+LbckcKD1JE?=
 =?us-ascii?Q?SWempvjsZ2baCBHCMGj2Z4IOtF6y5c9+5ZnLRJrm15A9WtjF7W23AItAc7lK?=
 =?us-ascii?Q?NbhnUz27i4GQ32cNjb97wLoTj2y9bbaOzdfgfbE8H1DmmSlRSk02OmNVXfx3?=
 =?us-ascii?Q?Ce/CL5f3tpYkO9a7SVFxI+ybq032N7XD/3aNmL3Z1feSdz212RVYkhiQYgAl?=
 =?us-ascii?Q?3V40E72Sg3EzC8edDxWDbzZo13FGsiaE9duFMfNRgyEZT40ymqNGYkT4zqe5?=
 =?us-ascii?Q?4FBFKjLkGRc5Rh/ExoUjS6Jm7EZtXv/UWCX7WQhqREyT0+4rqqFB/AuEb3fv?=
 =?us-ascii?Q?CCkOzx9khhOw606kf1AkJlguvztrzyhrKgzB12xQHaGRlolmwlG6eXqlyelS?=
 =?us-ascii?Q?dCjNcY+VdYEX/6Z7FrFsTkvAeLO7OFygql/XMy0f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66e5ef-bf8e-45a4-7b70-08dab1b6c3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 09:46:15.6367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mG4xO17YW73FCpTIVSlHeUogwYz5cCrNTFUlDMnU33U/Maihwro/MyvaEX0lODjBtO3KIndBo/WXKiwJQ2sIng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Saturday, October 15, 2022 6:26 AM
>=20
> +	/*
> +	 * User type WQ is enabled only when SVA is enabled for two
> reasons:
> +	 *   - If no IOMMU or IOMMU Passthrough without SVA, userspace

This statement is kind of misleading. Even if IOMMU is in DMA mode
user type WQ still doesn't work w/o SVA.=20

> +	 *     can directly access physical address through the WQ.
> +	 *   - The IDXD cdev driver does not provide any ways to pin
> +	 *     user pages and translate the address from user VA to IOVA or
> +	 *     PA without IOMMU SVA. Therefore the application has no way
> +	 *     to instruct the device to perform DMA function. This makes
> +	 *     the cdev not usable for normal application usage.
> +	 */

It could be simply stated as "SVA is the only secure/reliable way for
the device to access user space memory"

> +	if (!device_user_pasid_enabled(idxd)) {
> +		idxd->cmd_status =3D IDXD_SCMD_WQ_USER_NO_IOMMU;

be specific i.e. IDXD_SCMD_WQ_USER_NO_SVA

> +		dev_dbg(&idxd->pdev->dev,
> +			"User type WQ cannot be enabled without SVA.\n");
> +
> +		return -EOPNOTSUPP;
> +	}
> +
> =20

with above change the check on pasid_enabled should be removed from
idxd_cdev_open() and idxd_cdev_release(). They should always work
with SVA enabled.
