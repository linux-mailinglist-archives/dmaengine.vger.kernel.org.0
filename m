Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD64640DE6
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiLBSwh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiLBSw0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:52:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD9E2AB0;
        Fri,  2 Dec 2022 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670007145; x=1701543145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IH1M1pNIOV3deoqdbej8PZzhHo6dz34e2tTEXoV1oxc=;
  b=MFY5yYzD8E0ahHofJ/OXPjmcSkVr8NEvgzJZ0NWbrdW0ouc0ZAs2qD3M
   AMQsp9yrWgaYYgwsvLoK0MwI3sxFIxqHQP6nQm3kX3jcvvWvTx3nMW/hP
   Tp1eAgV5QhoJVhurEosUNn9fubjyISPqLhP8c89Yi1YPn+4BDgZ6CTOje
   kPdWot1pSzvMe4cIGSgE1jwsuFQJQaHIiyJV4fHVVU6kaJT/uTuZXJFvv
   2f/2C8Ash8VM94Pp1gp5u3U9G+By9ErOGFJTVvwcCNT/4BhYx4QLHa8tH
   OcGc4EcEV5xH2JBuCqJens4qAt3Nes/6akHD9BkmPFLf+enBCHZOC67s3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295717128"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295717128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751371528"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751371528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 10:52:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 10:52:05 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 10:52:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 10:52:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 10:52:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvDFaIlGYsbsMv0LkmxGhX4Jz1eJDa4Lm6n75mHW8bGEWubcCrpK4FTfI6ZZ7kiN+2NPRhlF2SLUEWao6fRUtDRDc4upmX80SRjNuaxHUXtNYNnngD9rKQt8LOKKVL9AFy9Gv9Wdelep2a5kY/Rgo57gbgWeyvfDNiUu84GHu8gx8NpHxCMEcu5Hc6aUfg6OMVuoTyk1jMrC+ycJ66hX5uhugU/9J8VmXIO8iC4QJ+dUmrnWgskOjXH+ciBhc8smHVm5PitqQ3QyFhwbR1vSxoMqo1P1M1ohheg5VesxDVkPNYKsaoZ1hWhj6WxEu1kGI/V1dx3/MTVmNZ9jxrONew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH1M1pNIOV3deoqdbej8PZzhHo6dz34e2tTEXoV1oxc=;
 b=Fsb0VXIRdYfQWWprQmI7bhnxlTlqtd35gUBGz1UNXfMYxenB/09iFmdUoFMDmUatUv8k0fe7xnpsUNRFQEjA9T3zlP4xcboHtxhKd5Br8lwBUaI4KUMchvQwfntTPbqHFawstg+0bqfyJFJSP4AyCbMDWtug1eYGDb/T/oCFIOC5OKnsuPWlpBJj4tWqEruAdy+K1YCvD+ZrV0HFJQ7UtOolqJPtu3r7DIKfD73uaSY7MHQc9SxnIXWOLjqVRy83ettP86rLNG6Af4fi9hlnRkbvVVNabfF+JSYNEPidbYtFqgx3HZ/QpGlaIkGh87k75S1v1BxYRioKlc2Q2bp1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 18:52:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 18:52:03 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: idxd: Let probe fail when workqueue cannot
 be enabled
Thread-Topic: [PATCH 1/3] dmaengine: idxd: Let probe fail when workqueue
 cannot be enabled
Thread-Index: AQHZBnt6r/dfPaz+ikuAhOUKotxRaK5a8RGg
Date:   Fri, 2 Dec 2022 18:52:03 +0000
Message-ID: <IA1PR11MB6097684DF4AD6F96D95EE1E29B179@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <1e74e8d74255ff47271c4c9eada7635676ccd320.1670005163.git.reinette.chatre@intel.com>
In-Reply-To: <1e74e8d74255ff47271c4c9eada7635676ccd320.1670005163.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: c726beda-52a3-429e-65d1-08dad4964d38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iX/I+GEsmzClus4EKECE6zmvrqHRrNIbSATPgz1jyskf+7mubEPhsL3HUIrYKBoi39TK47NcTFQt8ya++ewJWjTHqOfnuLw07LHCKDi4n65VoafLzV9oW9N9MvWvP6XYGM6EbfvXpgK67nq+gsHhmmq7hon1LAm/F0t2QLilppSmPx0xLCoYLRLx3KRsFWMju478t+h/VUBtXqtjx9asbTDsipXmNbkq0tqfyrGF5FK+km1LASFRCl6+Pc2FVAg8Q7391xN0uXuzhIa/ItTMEGdDDlJKEBT2EY7+ebQOI1rPqKmwk0j/arw6ukQM9rryi8hMSBcuP5cq0nXjkLeWeAOQdY+pwxjfDSVcDOwS1ABBnJFEQoWt5Z2isGv23IMMLj1T4z5CnCHgLNZwPMgZidjeE3NIc6cx3bDu23oaMeshJLZilQiCpnpzHQlXQIFe1Ir40VDJblrsRRVW3WZrr4z5MJAsOI33ZHobK/lHNoZQWc9w2fK1Q50tHj6lP1A/18Rtw7zesyZjEYkCY9Es77Rk0WGM6XW7oh8Pi6DfRZ7Lth+vcb7Ttn4mIr1FLocGfFyLjY3xTRzbBGlEUVdwX0ZYifB52qKPRzvmTwkEYPle7iZWyG4o7y4PiPOKjZTJeWsJh0H6EBPMY8AWI22Be0G4EKPGShziHKMv/ClRhLoerEkVd0lORk6yo18QdKvr2dj0OMeaBPQwdblXXOUEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(7696005)(6506007)(186003)(26005)(478600001)(316002)(110136005)(9686003)(64756008)(66946007)(71200400001)(4326008)(66446008)(76116006)(8676002)(66476007)(66556008)(83380400001)(4744005)(5660300002)(8936002)(52536014)(2906002)(41300700001)(82960400001)(38100700002)(38070700005)(122000001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ez0F5DvMMtdM/dHHlsyETpTOSiA8GQmHnVIy8OVZIqmRtZXZCI1slzYoFob5?=
 =?us-ascii?Q?svk+lbFVxkTjCmkXwN8Xb3b/J1wa9esATe6zUsPgNLgurQgga4ritvGVwj3p?=
 =?us-ascii?Q?wtfdMUmVnonwDMYg5wMVv5G8bhnZHmR4p7mimT3/5ePwpgIShLD3wgL2UIdS?=
 =?us-ascii?Q?A56HOG2C/DNJjkwf2vrulOjj0shcJPoBrMqsLMH3AlwF8GoHIq/FwVCwESOW?=
 =?us-ascii?Q?4odoN2Eiq+DsK0i+q7NY4sKwGw/gOe4iVYxHXwfSMAHTjRcKQWLVcQCs86TZ?=
 =?us-ascii?Q?hXiwnzKB9fQVLCBAeb6tqwVsPL7qx5Kvfk1hlkHPXqrw69GUuRWb/A0NLCR0?=
 =?us-ascii?Q?pHMhvNP3YwZZuhtKKQzuFwb0n3ZAg/dm0wejZr+sPgCMxdeAJuuG1dEmncm8?=
 =?us-ascii?Q?71XGSWkasjQii5kTlTpLPtjEK5aYkgidpkyOLGitXlFcAR4X5VAyKmrrx+xB?=
 =?us-ascii?Q?d7agKuKLpwAlgpgh2dDC97QD9KgU3QK7w1BqHlTBgWzOoBhlwsoo7kTnyvbm?=
 =?us-ascii?Q?XEniaNqmSV91kez8tQi//+BX9KfbB4ms8zns11Hvm8SWtA1BIqU4sVHB4gwt?=
 =?us-ascii?Q?KWdj/HlmVNItIej53btdvs4cdxzRRsqXVOzWuuFncppKhFeQWBMOIgFShiI9?=
 =?us-ascii?Q?LM6smeTbXtTQZk6kuHVvujE4llDrU83SFO+62qlPdep7u2oY+ehFJpjpWn00?=
 =?us-ascii?Q?RkI1+SGeJ3K+3GLwMJsGychj4wavvR8pP6SYRB5gZC6HhTYmuZsmTE4PDDOS?=
 =?us-ascii?Q?0LR6hM2Wqll+wX5XGii4XeqI2PUSZoPcZQnYoTaBISNe/The+hTwqOwlYnGb?=
 =?us-ascii?Q?mgmFQ75J2pZfTwxNmKWuaQsER5PW4DL/nrPtSp03aRszBBZRyqxkbRlDxt7x?=
 =?us-ascii?Q?Zp7Y6RTfR0LZr0/PNhrFtG06E6LYjQHB2aNCMf5D3ABLf8igTiHpNMkjVXb9?=
 =?us-ascii?Q?LMl8ATI0zFnYM7bExXFcHTDCtTRJq2RdvvIFD6Ei+B4f4Gr1vAH5ujorfbuL?=
 =?us-ascii?Q?3Ps+zJNL4OvHIlCjbR1DFiTTsHSUdXhO0CwvDYpJMrlsZUGhhBu/mfyE5XA2?=
 =?us-ascii?Q?mEcQ67zmWJGFF71F4vBXwEfH7QwoDjTLqvdBeJiNMQYBVdpPvCV2tAm2hzmV?=
 =?us-ascii?Q?6ro537OApvrqdMen7fX31O2Yw2w1ChQdnGRqLqmlXhClNv6qid6OlT5t75EP?=
 =?us-ascii?Q?KZ8plV3sFoNhloN/E8melYSm5/hD1OQFGUnRtnvlK0+W0bxlmR4Dcpv0vkUp?=
 =?us-ascii?Q?XNHqMKZJqb3/5Y4Fj4D4pkjk3yr+92M3NraBsymDBv/mPvQWn5kDsqIw+8Ww?=
 =?us-ascii?Q?QF0iwwm5GEEhgEiXZN85VDJQelkIuHWB74yNhEIT5AfIE2v6UBWCKJybT3yF?=
 =?us-ascii?Q?JwN8K9WXC5GH3BaYgEnoXB1Rafw6DxjCXbwp0R5sWeuYSIXRDSYkBlLtpeGF?=
 =?us-ascii?Q?eCKDw8b75Z5fsCVqOCf2NOUgJnUyJsQ4hHmJ6gAAyn9Vr/6yz0wZrzwQF3/o?=
 =?us-ascii?Q?1f1gY/Al0O9GE45PGrW4SCS04CTLZr/1kJBrTO2U5IIsQCGytXUnNg2t73iA?=
 =?us-ascii?Q?rLIkIAmBzeilaYMt+mlj4Q/6yBaj4MNzzXTgDgd/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c726beda-52a3-429e-65d1-08dad4964d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 18:52:03.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHjIyYjWTN0poerM6Wi6g/kvthzxOTbKzO6vSpKgcM9/vkdi63kufPMchOy4FXvII1sY2sN4RKTXyKL6yuHO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> The workqueue is enabled when the appropriate driver is loaded and disabl=
ed
> when the driver is removed. When the driver is removed it assumes that th=
e
> workqueue was enabled successfully and proceeds to free allocations made
> during workqueue enabling.
...
> Fixes: 1f2bb40337f0 ("dmaengine: idxd: move wq_enable() to device.c")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
