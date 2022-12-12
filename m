Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CC64A785
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiLLSsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 13:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiLLSrO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 13:47:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B61F5;
        Mon, 12 Dec 2022 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670870833; x=1702406833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7MGOvzQGvGEOS+eZ813aLLYZfW2Zk13cMDbdFZiknk=;
  b=MvxfGqUACENiqsdNHMd+aAZ45/aK34UHxR+KO0P2alfjt+9o0TH/32at
   bZF27FKAYs9G/DjTbcRRkYwBWMoFuGnoG0CFn+j71P5HUK6RXkYOkXD2J
   r/V33/Xu0Ww8tdYbdhNl32Ej/x6Nzg99tKp0PdTePgWEZFwJ5pt8sODGP
   TWannoYg/gPgzBQJOSvKOaadTSDurnwS+y3/OtkVUU1rL3e594aLAgAv1
   IlQF8/48TpuR3yJ4pv3Sz91zfhZFiEu8KgwGbfcQXE8y8Ki+mzEIBCgO2
   wmuGW/fC1Ao2bNgTS0jJ5tVhipA8H/ybuudMbJjW6lPbP5HHr+q1kY5Ym
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="344988319"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="344988319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 10:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="822588748"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="822588748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2022 10:47:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 10:47:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 10:47:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 10:47:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 10:47:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhGq9SmXQA07KaABvjy9z6GPjNHgX8VBI2ZViTwgTi4ARnq4bowf4ORH1ujfW4obTlLeH6D9yOdbkz20XoufzByA1PipyDt1IHkkhjMfQo+f646RKhGlSyWXY2P0yvAp5OPhuID5bjBDBZfG/teoeV2c0FUVpE8znAB0Fg3LRSWfEpIrjPvNCnjk4MMcPX83ZGzdV4uMvOogeZZGHNw8/kG6WsqFC9FEsnJS1hIy+fpzq9G3cV+bB+ZoZeH3DYxDxtH41A2MQFW4JngkRmKNwaIl2SDUQCuS1uBgpdmtOIrCYQagXLWO6vkcgJCu0ly3yKIyx7T10WFHwfLplJqoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+9ycn5tizB5qSoOuyYyxMsVu7dfyppW8n5yjJO3RvU=;
 b=TAPcv7reYu9f3jlpf8JW0Vr8HMDDOMXM3aiBsAUqKHqMhCUhixTr2OF1+8K7gWjxlQxU//wpqR2Ra0o4tKEqB9jIlOSXsDBQrzZfLgTD1RwsDyQsCu5IJZjiG3pLs53DDxsBfB944ZusfAtKMSc41cQ3x4pczC14l4pYQKiM6T4yPs3jQpdP/iNun71YuVnZh35ONJ8M0R7T68LqOyv8H7SA29wqk+WijMu2saQ6f5U4jf2eJhxiOhnQ2UQjelWmef209dgBvGiAfpt1yQW9NZAURRqdanUvC9ku5laa+cozEbbEGtk4MocT03ceDmy9G3Y8P7e63+Pac2Tu1g/K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:47:04 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5880.014; Mon, 12 Dec 2022
 18:47:02 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] idxd: avoid deadlock in process_misc_interrupts()
Thread-Topic: [PATCH] idxd: avoid deadlock in process_misc_interrupts()
Thread-Index: AQHYtw0S0FsWXwDkFUuidHjlLK0eA65rRYpw
Date:   Mon, 12 Dec 2022 18:47:02 +0000
Message-ID: <IA1PR11MB6097183F44E96BE3FAF119DA9BE29@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
In-Reply-To: <20220823162435.2099389-1-jsnitsel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: 48fc6700-6b99-45db-e552-08dadc714229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIWomTLaI60gRjH2DVRI4yWBoZ2TaeYNbQKUdl/PiBH9wFC1RBNOxU05DCnEj39Gq6rlZif/rBN+buHaE7Q872Ji2xI4b2oN78SJxYPh/5RmTMI/sehTycD8hXQOC2Zrf/mylfh3DyDL4//WCYeo1sB0QN/dgYYDZHfOQEm7pitiTdVsyWCjWSh7QNGHeeJyrSw+DIXL5/d+FeC4BSOrwzsjgXuerszNCKgfWX4R1PSBcru6G+qvvXX54U0ng0OGvueVZeRed1eBBLUtqAZshhCL+cntYyqOcljktIS3bDE/24iIm9/w6U3EbweEaaDgvxtls1Q3iEAa5F3UeWi2caN8WwrCmlpq23k41Hpsl6JHRBMVkvNn/yAT6UJfoYQobtdeWP5PpEZiOTOnVVobI1zoBNgs0M6RcHU9G2hNWI8qpw69h97ShNTMVXgAeLBsqLT3zQx5tP/ivPaf8kkCuMgm8J3cXWjzSY/ep+Xz8dksp5mvuQf9qQFU6NwgeEDZ0P0aLTFdSmfUVDiaYw5oKkTVrkBwPBUIt4Hyb+zu6nxWVEUrD9b/3bnhuRiF9BGEFsu0rhaG3lkcoJBlw3WxXk8HZYOpD2bFM3THa+kAUVV4iXDqjYVsMNUuv9tcg3/TCFmN9KbiUhurJKARDz0/zL9Pn2kgaMjb8PMXjAmsaNgbl7opUeCM3Ud/q7+32bPlM7nb7UG9qNTCuZUo2D3fLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(38100700002)(122000001)(82960400001)(55016003)(38070700005)(478600001)(71200400001)(52536014)(86362001)(8936002)(41300700001)(66476007)(76116006)(66446008)(4326008)(9686003)(2906002)(8676002)(7696005)(26005)(54906003)(83380400001)(6506007)(66556008)(186003)(66946007)(5660300002)(64756008)(316002)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzanKRluSm4+fCOHEcdVGofTyFRlsF7eVI1b69s8FNf1pCH8/3gaD1C5B8TE?=
 =?us-ascii?Q?L8fEApRiLtRZtv4Yu1RKk0sn5KexEdri5jaXS0jmNGDpzlsExLDsadJ0HUqQ?=
 =?us-ascii?Q?019o8slDjKQz3WilgUV0WF9irfWdKDpsvBrb3jEfCQRGkTmCX4IpslyAhUuG?=
 =?us-ascii?Q?l/tA2uMcoP1sz4/1hvB390Q5W5jMtZxoKjg+VPnKuxz4B/9cVsrWdbNCI7EW?=
 =?us-ascii?Q?OKba08qntlgvIGVElJrN8J2AzPcezpYljaWaupkpNk2B55hI06T8Q9NXTU/a?=
 =?us-ascii?Q?O2Qt1xQmtHWkVkGUc7JG3eMfnEcWj3Wz1u9PxxS5vW/KLx2jB8uILaAlntRt?=
 =?us-ascii?Q?7wcaQJIEykTulfOH/FseFZWbfiSFSpaKzKRonv51QGxnhi8APtGDKAn9ESUe?=
 =?us-ascii?Q?lz25NERQJWrY3W8ij4zO/rD0wfDU99HOf9CIwGbZPAT6pnEZ5dTWHh2U22+1?=
 =?us-ascii?Q?GjZqLcvhYFFk5x1wGfYclB+9Guom7+NGWkcx/Pyy+NIoa6RooJ7HGafyTQEd?=
 =?us-ascii?Q?yVQcIJ0pJ9piuj3vZac9DfdbXEKePVglamw+wpl84euvD+EGfLJzHQVbda48?=
 =?us-ascii?Q?gRa9DnAfCZ1qh4a0j3ASc9jtOcJazbH4ErS8E8y1moo53vAdNkb8f2g1k5AR?=
 =?us-ascii?Q?qFXVMx3My7Gtx8UNAWG0VrGESgjDUpzdWoN0mMUc6CtCvyh1TpdXkof3aJWq?=
 =?us-ascii?Q?xnUNJKV8mK8EfWsWmaP8Vb8PfXZj4TR92IzX/JOqz/9d5PNGRJ5tEKaOGi4j?=
 =?us-ascii?Q?dD6CqI0DaMbhlsBztkocqnLGeIWZcwQMt2G/VdUPU7I34oa+ckmWpRCfVasL?=
 =?us-ascii?Q?muhzeEvIGpmz8nJTofguym9wLVUmVMogSZSA+1W2vS0dOHzXFlreEOIS4aA+?=
 =?us-ascii?Q?2yV4ODnSmSBo766zcgNY91FJtR7Bsa+yoAE8iyGJy9IoX69yK+A1mCV9tFSB?=
 =?us-ascii?Q?3ietPzBpOBh+c5/YXDp8IDVgqp4MXC0V4hr0wSN5EiBibG32mpViGfYQQu7y?=
 =?us-ascii?Q?bfiVf32ujZK0x4kv36SwBUng4nchTn66sHoAAYiWu4Vk7K8Jx4ZBxSwplwc+?=
 =?us-ascii?Q?dyAdgrUTN1xKiDC0ED146Ct1BxwqcZ9NfOo7Zd+GbgpmfSDgkfIIrfPljqyJ?=
 =?us-ascii?Q?6VixH7g3D+T5K2VK/FF5Ywzjm5CmQuNtN8XRXLVVNLluNpSdbg03GLQbV0cV?=
 =?us-ascii?Q?jad6SYqD0WiPWDcLD32wTdOZGt8vKDLvb06ZG/Pq56y07fTEjPL6AYCBZN5P?=
 =?us-ascii?Q?pokkaTh+xO/uL3c4SoQ/2D8hdsbalrpFqWcWM95lKM9L0jnGrGtNX2oV+rAT?=
 =?us-ascii?Q?UXLh1Zjartx+NAIojmHQVi7m6FgUV5dA/+Wk1TY5cgw3dy8awEs981LkeCwT?=
 =?us-ascii?Q?CcAjvxriEA/r6Hnb2WQCtw7HwWH+EhKw3RGWmw5KBaAu5g9yDeiGZr8wQaat?=
 =?us-ascii?Q?wUYWOhbY7qNpYa64CzyOXH1M/N+VDbemOkwZRMtetMfO3lLCj8ncwPZ4lS+d?=
 =?us-ascii?Q?+qwEJgcQnbiP5iCXjSYkjQ0YBlIP3UuTl0TE3dIiKCvt2b+P3TecbZBSBH4D?=
 =?us-ascii?Q?hfC6ZJ3j6+RikqLpgLr5UEc5G8Wn4rhb6HDw3zTi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fc6700-6b99-45db-e552-08dadc714229
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 18:47:02.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhiMVZTIippWOcbZZZzMiNTped3lEMmRcdzYDlOoBTdYBiNRJV7FBE3KBFAwOxUpC5jTYuFYVDHnvFbV7ygJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jerry,

> idxd_device_clear_state() now grabs the idxd->dev_lock itself, so don't g=
rab the
> lock prior to calling it.
>=20
> This was seen in testing after dmar fault occurred on system, resulting i=
n lockup
> stack traces.
>=20

Please add Fixes: cf4ac3fef338 ...

> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/dma/idxd/irq.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c index
> 743ead5ebc57..5b9921475be6 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -324,13 +324,11 @@ static int process_misc_interrupts(struct idxd_devi=
ce
> *idxd, u32 cause)
>  			idxd->state =3D IDXD_DEV_HALTED;
>  			idxd_wqs_quiesce(idxd);
>  			idxd_wqs_unmap_portal(idxd);
> -			spin_lock(&idxd->dev_lock);
>  			idxd_device_clear_state(idxd);
>  			dev_err(&idxd->pdev->dev,
>  				"idxd halted, need %s.\n",
>  				gensts.reset_type =3D=3D IDXD_DEVICE_RESET_FLR ?
>  				"FLR" : "system reset");
> -			spin_unlock(&idxd->dev_lock);
>  			return -ENXIO;
>  		}
>  	}
> --
> 2.37.2

Thanks.

-Fenghua

