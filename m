Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D846BC6ED
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCPHTT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCPHTH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:19:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9E5A906;
        Thu, 16 Mar 2023 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678951142; x=1710487142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vkT4aLd9hu+vlc8qfEeWPPFt5+jGcOw0AR/DU0mDC2k=;
  b=JaFR2FoNDKJh6Wi72yW9x1R33XHoBC94N40ccq56mO4KiFVUgGinovQJ
   2Pf0nxBAZyGtxD8DoqYCGRItTx0bKDCbAG6aAqGudDNf1H3dO6GEJM/wN
   VKCHUaC+tFvKrKybyLrbJn1HKVvfKMddax0BEhW4OwC7AOzK3LEa+3m1j
   ZRXfUC2HzDrP93nslj843KCEx9zLk9Wurnr2efLPpsyqnH6GUAiBuEQ08
   JI7Pz2Mz53mGg8ZPrqXJ7QjttIzaOS6gBjpXmiyWJVGRyXMJ21zocWqS9
   CQFC1OMSOrE66lscq5oprustCW/WU/ja1hrcu+vicrWITlE9M40mWQqq0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339442857"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339442857"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="744014573"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="744014573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2023 00:17:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:17:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:17:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:17:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ1+65887aLkQ1nplkxSwHR+UjI/g3bYKqxxpDoG/7hQuMsQ85m/gQAtB53YIgqsjOcPiFyv/17evOXsoJVxWMN1ADQ7WzcRmshBNWvwQwzFfmTQnWspl5ODQjXkXPJR9NFOGb4D9lIyFKIA5ndt2/pqZqGUf/bmju453lp8ysNfT9CGx+6L1YbctQHtZXI4+s6xgrN+8jtC3oWMPAfAvSjHDRMvb/6MJ8+edNlxBHYVAD97T/9dljtJh5D9fkbbX94xk+NJn3yL20/RHHFPmWJ18mGs1puPf9zC7ywZht8Jh4iUm6s290uIKk80a/x9DDjI7c0s5yTSi3/sPtnWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XlMQSHkige4ecbAhaT0cKaczNKCbRtE997yp8juA1k=;
 b=ASEIsg+yhQigozUB6H9WwFH6IZ0HjMUhDNMFcUihbaOrSFs6t9bP5Rluw3MH+M2ChbDBYiwWFG3dArQYsNpL4AcKiNT0RyoyEILpCrsLL6fZbqDuvzmE3PW82+lBWoFsSTINL3/B3t6hfxi8kK9DTK6U/5fK0fschNhQlM7j90S6y+RrFEdtwJAy1WAXzm82+inOKBxvRPuahXDDAO/zV9MJwTOkQQiYpA+SwPqlII6YuNBBZho2OujdUJQ9WdcULrMswgWh80G3yNqQiiPqW6tWS0bSe4osl4Z7WpoV42bbFMpTQOw4zMfua/hf+iKmH3VQQ5YhxRGdygke50zUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 07:17:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:17:06 +0000
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
Subject: RE: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature path
Thread-Topic: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature
 path
Thread-Index: AQHZUjL48KR1g1UW3UyUdTfzF/rwfa79CJVA
Date:   Thu, 16 Mar 2023 07:17:06 +0000
Message-ID: <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-6-baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB8356:EE_
x-ms-office365-filtering-correlation-id: 17265fb2-5cf8-4e78-e8ec-08db25ee72cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdGm3uoO+i4I6rBgpp7NRS0gAGpuwNwhfoSa4zsI+M7dg19JEWMxlaaupJ5pAcogrX2LEgAoiu5xfWo8kerngLSnSJ3sXx5BJCS/4ybPxzm1/wLKvuaLXG5TWHUXLH3Fq44jw99OlyKInYiFTurU4WF9aPYQRdPHEIJ0287l1cu0a2PQNv0UIowOhGoEJijT31oEA7S/8P2FsfMCRmYMhbjIbawdo4oYnGoXC0R7gogYSrvazg4zvbTD+zSli2856L4e2FSCMeZpkZwtcI775oO2xD5pSeag6DwwAJz2q6cEoXQutmPC9nfj7Cc5+hq9wQWucx6QZg6UXlV3FBtIzOJYy6/1FoGG2oOrsFFU61cvxqpG2nso5FW1C3eY1A/Hsbdoz3hOZAi5w4+xzp96CuHSOHZZpMFWuZi3LXZUV95E71kZ3SkZkWbEttxq9J9U/KC+ZVILA6c+tpHw8L9zCj1ElA8wclMAIBEOWxJ97yoEeOvd8WRjKjk9kfHHGo4Lfw/F1XyHmilWsxcEfoWgf/rdnd3tEazn8UTK0Du3FO0pQJCLGtDXE2UvH8Cxy9AkA/O178CThpWb28e2jyWcXuT/D/BknfxTUsrOxsN3vBbjjcy5tZtG/NrhRsReDiNGb9xNW3EZTyg7TiAygGg+R9rxd8yiHdIfDH4M2ZWe5oSfXxifvDVoO4aKDV7jXlRBBOfV66oDrh5cfE7W8nYDAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199018)(2906002)(122000001)(41300700001)(83380400001)(82960400001)(110136005)(5660300002)(8936002)(76116006)(55016003)(66476007)(64756008)(66946007)(316002)(86362001)(52536014)(4326008)(38070700005)(38100700002)(54906003)(7696005)(478600001)(66556008)(186003)(9686003)(33656002)(66446008)(8676002)(26005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J8cG86p9FrIKImf8HghI0HZBmb+flkjj66PCzZSldplWeyFbRIWKdioTCH99?=
 =?us-ascii?Q?u5eFkDRjzOFgnhpeDtMC41534yxXj8ckaaUVffZfRmDtRej12tH1Tg8fHysG?=
 =?us-ascii?Q?Mtm6gpYtErD/7a5B4+S/NQ6q6wDPRdEBIvseYR4+m75O/SrZ5oZEjHJf1gka?=
 =?us-ascii?Q?I3zIx4L7Pui3Wgd3fbYnnkqTG7ZuSEI7jY7pyE1gAA32yqZ764wFxEgZpUTk?=
 =?us-ascii?Q?L17YT3heKJsqI3+MFcHFQK7PfoAgDm8WTMAGv+lR4RhTzGJGDGNQm1ULlK2Q?=
 =?us-ascii?Q?3VCWmjDVawrm1LCfn6JwJy/EMQN4Pv+buEKaZ16VC8m4POYv1jRwZ0nnJMJD?=
 =?us-ascii?Q?VjiJqUNd7NjZSi2iEZtlfeTAtdWGtSit3e/BgwAnNe7AxrOpK7Q07UuGv8zl?=
 =?us-ascii?Q?XumW07D7bt0m60+eENiBXEIXlOU9zGKTQHJQnQB05ZL40Bw6heOCmHUdJ1K3?=
 =?us-ascii?Q?kD1SQDTXFSVTac48j5n5HAeDf7oGPY4tnHor9SUUTYFkrg9/I+ylPPr1mkOt?=
 =?us-ascii?Q?3NX0c2DdE2N9/8UPXeAqkuIBM8uo+4JUo8MArLyI/cT+P4OZMNrIVd7pOfaR?=
 =?us-ascii?Q?ed0oVn9h9V3zYCsi3jGqA79yrrXzM1cxfUmOJ9MX6cYfHuuGVJior3fUIWq/?=
 =?us-ascii?Q?fiTqZUi7T3G7iRmDvMO5AD8b+Z3H4+FUcK2kJPwNnGPXa1+tKw8619d31OwK?=
 =?us-ascii?Q?uvGdzTEzFCHzYS9wnI1XS56CjGhLWXg6/25b2iVoHC4J6EHsxJntAyuZKOqw?=
 =?us-ascii?Q?iGKWZJh1ujGIp73OLX5Bbg4R/eq8eI7/ZGm0CXaPRojfBjsuP0dxGiHqWATC?=
 =?us-ascii?Q?XhjrAQ/CUlMaOCjMaBDe0NG1fbN3+EMLtW1SW65HXbRDx+mr/uUOrCenO+cj?=
 =?us-ascii?Q?II/+0XwzXYq0DZDJiqB4HMvfLQ82GbtYYWyRBYezDlUCkykc/WF7/AvTuh7r?=
 =?us-ascii?Q?TAFbKmwpdwNLi8wo8RnfZWkqv8rX0HbmiX1aQkOdQIc0RZmNpNsoFZF69Tnb?=
 =?us-ascii?Q?FuJnw/X9oFoByCHrF8zWZ0JTTpvvYn/8fx3LApz779DnEAJTa8EjboUKTpbE?=
 =?us-ascii?Q?WqZc7ImRF43bKIGlW6uCiLXuH34bojvfB+rlkLOULla2V+gyBSK43cDSmwlX?=
 =?us-ascii?Q?I0OYpx2FkwYVqQlPEnLlL24y8dc52s//Z3G4uJqYLsKaiaM+YrbRG59QmosL?=
 =?us-ascii?Q?6VQWcmMV22U4+Pm3wiufteIUjVw2BppnnnxpfDEe7IRcECUoo3Wk5aKacQtS?=
 =?us-ascii?Q?hJJC8MgNyEoZWwX8M1n+XrVwimtpLidoACqh+0EDVP2wkyT1k4OoF3JqSAqE?=
 =?us-ascii?Q?FWb92pZlGU6hZbOj7yfCf0X+w/W9W9Lp3eR1tW8GgGSWkP0CuY3TGPnukwIY?=
 =?us-ascii?Q?uvgZY8xzo/XykcPNUFrtKn9JjVN1EijsCuXBgboXB+SWFaWhyJnwh5oIth3o?=
 =?us-ascii?Q?ew7XPp4B+r3MTkbZquzJV19wTuYmcseUWYEK2NRK7X0E+n0uK+7YknIhvv2b?=
 =?us-ascii?Q?0iOGxuMQjNKrw77dfGF0Lg7WUqjfaLg3R6ARZ6ot2M+WqAcbg8+QxHzGgYVB?=
 =?us-ascii?Q?qwtg/WLCS2wKee9vHHrYLOG/gf8LaMCmGmRHE0WC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17265fb2-5cf8-4e78-e8ec-08db25ee72cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:17:06.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCe04xtdC8bZOtYukKbFTV/ljVpYG+/IAe4dsRPCJEJ9cQxRWJMQq6aytsvdTRCW2/GasahIk9TI4TwFERBuvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, March 9, 2023 10:57 AM
>=20
> @@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct device
> *dev)
>  {
>  	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu =3D info->iommu;
> -	int ret;
>=20
> -	ret =3D iommu_unregister_device_fault_handler(dev);
> -	if (ret)
> -		return ret;
> +	if (!info->pri_enabled)
> +		return -EINVAL;
>=20
> -	ret =3D iopf_queue_remove_device(iommu->iopf_queue, dev);
> -	if (ret)
> -		iommu_register_device_fault_handler(dev,
> iommu_queue_iopf, dev);
> +	pci_disable_pri(to_pci_dev(dev));
> +	info->pri_enabled =3D 0;
>=20
> -	return ret;
> +	/*
> +	 * With pri_enabled checked, unregistering fault handler and
> +	 * removing device from iopf queue should never fail.
> +	 */
> +	iommu_unregister_device_fault_handler(dev);
> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
> +
> +	return 0;
>  }

PCIe spec says that clearing the enable bit doesn't mean in-fly
page requests are completed:
--
Enable (E) - This field, when set, indicates that the Page Request
Interface is allowed to make page requests. If this field is Clear,
the Page Request Interface is not allowed to issue page requests.
If both this field and the Stopped field are Clear, then the Page
Request Interface will not issue new page requests, but has
outstanding page requests that have been transmitted or are
queued for transmission
