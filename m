Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B76BC6BC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCPHO1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCPHOP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:14:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48143AE13B;
        Thu, 16 Mar 2023 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678950829; x=1710486829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OLonzjw6CyIoJ0z7Lr55nWy7/IdsbmEB+kEa3Z1VGHo=;
  b=ZCuL96LcrRwZ2UdqzfSQw/k9ClwFnlFeqmOpJonS5xtonsRxdoyx35wt
   I4jH622q559RSZOQU53zwh/mKS7bZgzNb5MxmHc3W6xRVleT4AhLG4op2
   kscJn7eLlwBDKOC/gawT/mkoYYvp+s/tfaKyj1jCcrPUiSisVC6cWWDYp
   orMnT7Ylsb+9IEF7C7+quYMoXLAMtRI2KF0SfxH3iutlhfMgu2h+RmSBF
   /YX3iAbHmcztif60t41YgSsD2W8uHWyxn5aQcY647i3J23O4eix83ECUe
   awAzNjs3tCYMgSvo1GRq2VX+TTKr+MS9yyd2XLHIo8Zanh15ig4Wue1EF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339441247"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339441247"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="744011245"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="744011245"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2023 00:10:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:10:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:10:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzRH0kCDb9lfwQD90k8jHjubrD6bxqMKsHtI7tiWeSqxUYUYpzDNGvMEqZ/XHskwmPvtVxdacb8lNbIMxt10w6FEJI+e08Mk/2OvqMkJrAXJqMEfibCv2ozYVSkI8LhuTie0cBV5/VBXDRQHOp9ZTp4ZpRiPkEcxuJ5NtD7gHJunK73iPddzwGl75nMPOB1+KWA1aPUXwN+RR9h+Dib7biUcAKfPLNr8bQr0fdU7uDKjcUvsT6q6++4fzwWlIm7IQRAWBKFuM8iz5Rvn9fFi54G/WWLMZ7+z5Z4QgqQrwUdQOOU5+rrkINIaKG8REyeNbrD9xr+8yiq59adR9ZiGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLonzjw6CyIoJ0z7Lr55nWy7/IdsbmEB+kEa3Z1VGHo=;
 b=k6SQDquWehIoRLWxcBkcSuf83E2Byhv4LzdEqGmrLacp8BRsFcut3mGOSPS6EkNaArVq2tFfMffuSkaATLdd3u1vfU/kEKp2hkzwm74ATTZRXVtO4/T99j7Otb9q2zGWDTKFysld2hChSK4TX/tEz9P4BKHWoQVXMyM4pAW5YSFOADNmjLYDiPSDDnTOUnwE4mHn88l9NJz4cWUX29TEI6W2mjwjJaH4m/uqdS1zn52x5miiE9WNaS/kKm9gNXm1BEjduR+hznJej4ah+I+Hp1v+uTYA8APNlXPCnL044ta2vjdfMpm3ls5uVTVMDmZ43rW/3Q/WoISf2AK52RVk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:10:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:10:19 +0000
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
Subject: RE: [PATCH v2 3/5] iommu/vt-d: Move iopf code from SVA to IOPF
 enabling path
Thread-Topic: [PATCH v2 3/5] iommu/vt-d: Move iopf code from SVA to IOPF
 enabling path
Thread-Index: AQHZUjL2iz75z40pZkyMb9WWEztj9q79CELg
Date:   Thu, 16 Mar 2023 07:10:19 +0000
Message-ID: <BN9PR11MB52768EE2CAAAFAF78F90EEA38CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-4-baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7757:EE_
x-ms-office365-filtering-correlation-id: d547bd52-4221-468d-39ba-08db25ed8071
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Tt1KCBR+IigiXSFa8pCaQbF2RT0PhKdF7MmtcxR2NEYGlo+2DP9JeeYHhDJwzl2p+BJExic5z2THJMAKqsDf1HOHY6buVfUH7+LT2lIip3QvglKxBJLziwx3aFYUl7kWfdx0gdiFW/RO0DI+aLQsw8V7TYGMGH8V0ODYWqwclVNSzL0uYnMAY4lvRDceRGgRYGslTQVhRzY3lt8ymT0+vgmQNat0OUO6q8UuweqZpxSSKpW+lA1WteH+xzyMVnMpK4IAMQAZTSCEDURGJ7uP6KIT8h67qk2HA2tCyY+Pp5l3XOdjmKbTNPg+mUo3mfmAD4BRyj0sQXskfpCY8HH+kNmzu6M9U/zAW+VZfiSMrButbLtTq7RjMuPhvrrRvZzd9o3Maon0GNBUl3/NV620TbouwglNwZZ6BNiLzTqYNu8T483xGl8zFOCBQ+KvETsIEhngn1h2+n3Dp6rsDnGm87/mkueC/z9JBPU0WeO7NkF1h57xG9XdCl7z9E6tGwJvmQ9zqY1ptKvHCNEnV5N6YYqW6QYHYn1qSssxpo1L4CMFEN89F3sW44CpLmhy4oOmzCnoWfWpjWCwMyVI5CQ6rbrpSGdjC5lsJdKDy/UMlE+QI7GXLpyYyi9zK1j0gHQVXASTRkLeeqn8miEqmlaZ+AUOBtBOPU7oLux49Kuyrnv88Ds3yv7L7/8HaJ5Z6AnQGSGvRBgw//DL6navB5eFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(38070700005)(82960400001)(86362001)(33656002)(122000001)(38100700002)(7696005)(2906002)(52536014)(41300700001)(4744005)(8936002)(5660300002)(55016003)(66556008)(6506007)(26005)(9686003)(186003)(4326008)(316002)(110136005)(54906003)(83380400001)(66946007)(64756008)(8676002)(76116006)(478600001)(66446008)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Kt152s4sIFyNZOhyqay24BKHoE0KJLzoCebEe9Z0s5CEMadMonJxRcuVxJu?=
 =?us-ascii?Q?ArzHi3OIt1e67ouzT+9bs77QGgqF0Ip9QO/MFmD+ZMam9nW+Th0Q6YH3w33g?=
 =?us-ascii?Q?t1+UxfeSkyWTd8h35l/oyzgVjAntzoYh4UqA979ANe4Vn7yq7TbJe/GP/3T5?=
 =?us-ascii?Q?fhooSKbxXGSmo09WMey/RU4EYKB3DzFd1CpcZ4KKaPLJlUmFHKw0fzCzv5KY?=
 =?us-ascii?Q?RL4tTndEdh7uaKV6usxBwFo0IgO9lFFGsBCiVcJE8HzHnTjqKWafbskAlZ4s?=
 =?us-ascii?Q?VqWzntaDogS4sfUlSUusT46ASzXbtoxjo/kvlE3YVvL8icudiFUxQ0298fdT?=
 =?us-ascii?Q?es0qvIr2UpccYlRhpOUxwW5Nay5hQEerwjLDq0scyOSCspQv3F1zC+ojgIy+?=
 =?us-ascii?Q?quAa4Q9AZ/PbkpruNrdRs6Mr18XcrKvvEGkZxtKSJFZgrAuEUOiD4qLeQ/VM?=
 =?us-ascii?Q?Hc7ebiI9uc2BASzUW5nDISKr4a4xkruQUMmMFuNl9Wj+tzmzzJm5lOsI2yHY?=
 =?us-ascii?Q?M0hXtPq8qOnjS9es3Mfm+LsO0HIofmcC0ZREpP8PE69gdCNKjFk17ZR/EH5E?=
 =?us-ascii?Q?XFWDzGIFPT3jzrbIsnpFdEbcSIm0T4cvMK7WeUpoAba3fNkUoZoc3riR0WZA?=
 =?us-ascii?Q?Uqfe64ZCWEEPASJLM3Kb+G0xWKThyFuHgral+ahY4dLWTTDwFY55vzXsdkvs?=
 =?us-ascii?Q?fQ/TUxHpyHTpd+lyB1jMjnEOsH6XENcrqMlMeU4W8na4jU2seAA23w4iEKKc?=
 =?us-ascii?Q?MYf2dJeuqi92LHhr/65ysP5DvU80R4ZroQ1EfZMb/0oFoTRPDJKl9OTrjguc?=
 =?us-ascii?Q?cK9WZCGTWsSy8fcfwd0WBRCAKXiRMAgN8/5XjaSsCWBKNenkdjxeGBJo9SCQ?=
 =?us-ascii?Q?Lv8mpEhVoqYE2XNRm+zedHgjcY5AA295smCEO56vnPX4lfmXzLN2Zdt81aTv?=
 =?us-ascii?Q?mAFbv+tP39cYOpNwlYbisymzYhzOI5kq8POoV5R2yq6B9OnZPS67/lY89JHp?=
 =?us-ascii?Q?3kQ7xo9W5jnJuYBg86GGYU1kq17yodVNwjn1AzRFPh8inENKIOeGIQ3vXkzZ?=
 =?us-ascii?Q?NC0ZegmZbX5ZY9+D/qMpHqGBEH91BCUQrEmJlmVIfWZZUBs/ARzLS7eNh8DV?=
 =?us-ascii?Q?Wzj6vZGpWevlHUNJf2Ndg6IY/tlJ2gkTcl9784TQMpOpWR/Zodl0GZ50yx70?=
 =?us-ascii?Q?Xuwx6Xcn2LpSitIx97jSYPwUPrpw46RhG4LE5O/EHtUadDonvSXYVoMbS1va?=
 =?us-ascii?Q?rm4a+PsZHJT4N5VIoOn9G9XmB1Mx+JVqrJzk0cTANv7DRTqGq7l0JzQdcczb?=
 =?us-ascii?Q?ZF/9wtVebluL1kwv2ldoBcI9FOgTzMdrnKrTQoo4kj+JNIM7utG0NUgZFTEu?=
 =?us-ascii?Q?QITwuT3dZ1zBf7560suyreUrCrXOLox0uLekTjmxen65yI6JSBixOEf55Mde?=
 =?us-ascii?Q?+cBsNBOEttTZ1BrESy9ScNCIZ7NSrrmNGlBXGfhbL+OfDxs37pWI323iHEDx?=
 =?us-ascii?Q?M32S602B5bk08Gn1rNRjgPxfM0vjRCU3i2ZKYt2B3lJ4IwNfa1T6O6sLE2gg?=
 =?us-ascii?Q?HYMygE/wO+x5+Y6ySaTXo6Y8CjQs7p5zLwNg8zXk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d547bd52-4221-468d-39ba-08db25ed8071
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:10:19.4799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpY5qQKeXVg8sUAshG/wzQ0WFX1/laIDYuO7PkcYXjmAK6HEXzOuSADKNWNdo2ftDfyPdraXe90CF20a5eovzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
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
> Generally enabling IOMMU_DEV_FEAT_SVA requires
> IOMMU_DEV_FEAT_IOPF, but
> some devices manage I/O Page Faults themselves instead of relying on the
> IOMMU. Move IOPF related code from SVA to IOPF enabling path.
>=20
> For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
> IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
> IOMMU_DEV_FEAT_SVA.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
