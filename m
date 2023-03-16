Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DF6BC6C3
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCPHOc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCPHOU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:14:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959324A1E6;
        Thu, 16 Mar 2023 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678950835; x=1710486835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACQYxuXzJ6SZpwVVFUOSNXRh+WgZFO1RrV8IY7zDhJY=;
  b=mj/+5l+uCMLPNSyjFMyR7ifwKi47oumyqrJOPm0ipeuWOoVINhlFy8GM
   BQXWmd5hcbCTIfueNvHApVteAoXHaY1lF5XfihFqiYItdwoRR6TQOBGrW
   PP/r2+xNFTJqcRHwIK1M2GkksgXpGMoziEc//1j2yyP5W8YZdm4Ok6xBZ
   utsIqfoQgfZ7dAQwkpmrTZikcE+4bRbFt02elLIMKNxIic71wpjts/vji
   rFv4yomIZDrJcDojIiRI8u4uMoY9oZ2Vd3znxn7dELKEIOTmRnuUXU1LF
   Xb47UeQZnpG01/hjR4IAxnJpvy2zxZRMLCjUE0LD2gpkd1M/YiHAuN3gi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="402781846"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="402781846"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679787573"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679787573"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 00:10:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:10:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:10:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:10:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHoHOfAGzcVQEFPlJZO57sX5V4DeHcMKdDmgHNb4Oiuiyo7+HJ+xvqhuE/4k3GEp09XiabHCfpIUSNZH02TAKprIt0f8vBKCKFLnE9yozZRG4/S7LOnGoCPnAxO0WwLPcc7S8vFHTjSXIpo0A5b6pKgipzm5BsXc+/ElhaoyCb+4FkjkatiEcc+kIJWcV1sWKF0KLrYoFg19kp17bgb+aKpJF7tcyfBrpzrii3OcSe6IyE3yV4zLiMWXJ3P5yxp5mxgibYrjp43lvDyNzRo9ZBsswrQgk/fvNix/hfE88+fRrlEe//1rOBlpSykZPf3sF1S4vnMtlA0EIhQ51A6wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACQYxuXzJ6SZpwVVFUOSNXRh+WgZFO1RrV8IY7zDhJY=;
 b=dHx8h9pqgcc5en1ggMVPv5y2dkERVcIB1kwoVWIk8ebD/ERDBgz41JB0VelRPUl1IE8sR0Ehx7/k9YHoXTUVVyxW8dMIyoqi59MM8AuEr43ehoNGeMsR8iKV2MnWI74/eQcq/Y+2tHCHX3xEZCg+YmiDp51VXGBrePrIXruG/nmXbUCkgXFRG5xaLALlU6aW0kfq6GZZOy85JEceAUdUegtUrJxOuQ6pF18Dt38L5c05ratbljChLIykXrxnrt2k5J/IUEUhllsGLHGXPEdwyL/bpOGIVswpP1vDYLUy+7o48MtrNlMl2eQdkmD67zmznuGLbLHPpKCt4SWCU9Om+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:10:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:10:52 +0000
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
Subject: RE: [PATCH v2 4/5] iommu/vt-d: Move pfsid and ats_qdep calculation to
 device probe path
Thread-Topic: [PATCH v2 4/5] iommu/vt-d: Move pfsid and ats_qdep calculation
 to device probe path
Thread-Index: AQHZUjL4z4IRengkaE+dOuifvmif1a79CGUg
Date:   Thu, 16 Mar 2023 07:10:52 +0000
Message-ID: <BN9PR11MB5276BB6C2725F079BF8D0BEA8CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-5-baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7757:EE_
x-ms-office365-filtering-correlation-id: e67cb6ce-2828-4a46-4b31-08db25ed9425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vW1wQW+Om2IAus7JpTh7yAbFe8IzaKWOWSvvELAAj3swOWxxCivSarrtwIUdUOBn86zMFsa9iRT7hUNWxD/LN8Gj1gqq+miXCHjunTRira6xDi3QepVAUTOw6sjW58hg6v2UI57se2G3/ZAA8suaeVI+v4MlF/SIbS6ONTOGi7iGTYaIohyVfDLJbxCd2DulhNAouUsi8YkmHxcgh1vNztbg9g64PZDuxcQArHw2d8gIyEQ2pnroAMVNSJMYdvUEaGTkETslij/q8Qc7e3azob/7HuPaDm1ApD/FzBhO2Z+mfUwNwHygT9Yr4LoFAN4TAc2SLNwIYrVNUCjlhQTuPcHLDXmTk3vNbGsiayqpnOL1/igtMvTue4LsanILOxtW2UDtg2F9zwIJNmoyxCtm0v7M27uCprYTfdvpvGZgRT94S866JwYlFGSa9fbBbw8wTqxlQ+jUtBczhFdExqEi3f4K9udfP6LrcPv85fXs6I6//kSI3KrNa4mKAMX4kb6jzp7moAE1clMdyXJjy8T/SHuLNYotKIJmHxSyXbhc8pUfDEdWV+7d8++vt8Z6haSBXKy7kPG6vVKVFFs4sHjwwkH32eM9YclUIJYaWnNsU7bVebELJB8LXaQUL+mAspmIzRhn2/cn9JXMghLYrKiGdfEmq8c3HguttKwy8Yyjpub5j+9fjGwHMMaA9EJrAFyncMouw9SA7sBjVyqKdb3lCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(38070700005)(82960400001)(86362001)(558084003)(33656002)(122000001)(38100700002)(7696005)(2906002)(52536014)(41300700001)(8936002)(5660300002)(55016003)(66556008)(6506007)(26005)(9686003)(186003)(4326008)(316002)(110136005)(54906003)(66946007)(64756008)(8676002)(76116006)(478600001)(66446008)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5yndAIAIYLRWb9LKUqGe3e+57nI+cSVZ+Qje528EUPr2EsDKd10WFRuXL9g?=
 =?us-ascii?Q?slNVZg5taEHtECBkujip2y+a07yEHUO/5pMjon6gdEJP6SWtGZQjAy6lKRnN?=
 =?us-ascii?Q?XF9L+6x8UlB8rwENA2myApBoYOwJlWFu6HfsIbsrg9gbdnf+Iee9yWYZoP9i?=
 =?us-ascii?Q?eLpxzA/aUW+NDEneRuy/rbmbMJkGlcfEDD6Qj+FB5LaKpW/Y+CuoGTROu5Gx?=
 =?us-ascii?Q?2N6J0Dh7T058hpaaecKlZyStE4yCkt7CwhaK4ua8r6BIFL1kCK7GazvBVCP8?=
 =?us-ascii?Q?uI6wupltx6vBt5AHTnVLXeH8buQcPOM+AV5HFjweyBAxQTnxMejCDugnOuAd?=
 =?us-ascii?Q?t9GvKEcWtii2cO86YkbIhhW2oMKi1WygS+nR767ksNcCxLr2+qcJ95C9VcP3?=
 =?us-ascii?Q?2L2gtHIB5H4fKSFOcVllqaPKExb2FL02uijpLSeUynMnzyBQirEWAcVjwpuL?=
 =?us-ascii?Q?ZhFas3X6nh9HBPjKqYl0cjpls8KwBQvY4DW3nYLbTCCBiSlmjL1rNgcgc87D?=
 =?us-ascii?Q?g5Q+q0eJ/tjURZNMHSCO0yRRaneYrPK1w12VMp0WRn3frWXfJHJ0QJohz5pt?=
 =?us-ascii?Q?XFGbeI5wgm3yFz5AaZYjimM7j00+1mIvNWg2b+A6isTWkwR2bk0v+LJ0TijR?=
 =?us-ascii?Q?ZN5ZXPit8JUwdJlPcEL6vFpvHfk3MlYk5BjJPnSjBS1HJ1WdxiiUwBy0Nhet?=
 =?us-ascii?Q?loTSfFhVGEjZajYW54m1QKTCmjUgjzY6AZtXodGMwC9VZ5kfktl6zF9I+grZ?=
 =?us-ascii?Q?xVYQ4tqLuvhCEB2Q1Byr9iKBw172mIgFD8xYTqvScqO2y+HE4rPnjnooCj9c?=
 =?us-ascii?Q?alNpLfZwci7ApaXRYTHZMBlOSDqPGVoD+LZnAGdRBTkh+rmWzXkHgLKZPs2N?=
 =?us-ascii?Q?2soupAqqDbRnDOPzm2PZXYy92RkPsmlrxTcbufxq0eF7rTMspDQ3f+eFANah?=
 =?us-ascii?Q?mNLlUy7YC1wSyS7WJ4yjIcSCxtrg0VxBRkk5WKEWbg86KWXM9FVq+Bd0q4zf?=
 =?us-ascii?Q?Oj4xIqUS1gFmiWiBfVMagUvVqxLVy7fLbcuwuwLL+Sjr6G0wSdiAlsQ9kU+Z?=
 =?us-ascii?Q?fqOjww8WlGk6/uSO8Q/fkQxIbx5eXXHQyHDXMoLiDIYGZHBzS7XFSNkZJEUm?=
 =?us-ascii?Q?JDS5QGJH6HbKULXDgtLG+HxvI3jrKNGpAqigrL1HWT8BfRkdddMRH309PbmQ?=
 =?us-ascii?Q?1dirJYeixBHyqTDzA1dgQEOM4DDIuI7cp6YvkvtcnrHQ0cLGoN5WndH2h9Tp?=
 =?us-ascii?Q?2EZcqrWCVXRqBf3+t9WY6491qR0XyuPKDuphn1WhCFZB9xRD+OwZ8TIF9Mvt?=
 =?us-ascii?Q?6BeDN6JDnwQgoWQOME1/MZ7czTE6spi2I0n2WvMN23yVyg23Q/ag80+p/K8M?=
 =?us-ascii?Q?sIOPe9pGN4CCa89n8XifyNHkWLrAYgLGwCknV4wCpC9MLK2uPTm6//LEPSeC?=
 =?us-ascii?Q?XQbbrOC8LWjBqRMMgYlhsV3xuMDZg8risQLF8K9ESz5cJf3GwmKYTbT4QfsB?=
 =?us-ascii?Q?6py/pWZNOod+KEowcIJzW54KL9IpFLN33CCe8ID48SrEkJwfHKHXinXawaCo?=
 =?us-ascii?Q?Ti9jgh89nh4ahbw4Z+VfV5mmeWdTjMRVABz5D7pG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67cb6ce-2828-4a46-4b31-08db25ed9425
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:10:52.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3yV49pbvmyUUZIijz9m2Re+KpWzRkl2r5nqNGPwFaObPfHpjdp3GpK+sM1hTbgwiyqL+yWj46ISlOTmDPPdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, March 9, 2023 10:57 AM
>=20
> They should be part of the per-device iommu private data initialization.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
