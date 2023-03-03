Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E26A9081
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCCFih (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 00:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCFig (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 00:38:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010CD15C84;
        Thu,  2 Mar 2023 21:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677821914; x=1709357914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oczNGZT7nmCK0v+MvsyJ0mRRuOISTTN2NbQ6w9bDWqU=;
  b=VsbAUZ18Z484K+woszUXQxpcQpsVt0wo5l6nytx8lIH28ZEs2ajpHqB7
   CUF+SMPoyKgVAuaFZKZicxWo3KgqIxjy+aBRZmklvmPPlk09h0gJVlci/
   zR53F5gM10w1BEFCIPP5D12x1jeHJvMJrCXsaN3V7xAINqFEaNYq8zx5o
   V5cl71kMZpXuJOdx2QiVa62Xg0VrXLP1d0cSEiylNeHX0KPmOFDIMpDcN
   RaDbK608pahd4NLp6Tqo6ezNb01J5ELhW0lrCQrbfAcUsoICdnL/XmLdD
   d2jIyeVe+TLoIiJZwzOUV/CLOYApbi2NK0jwYIhXiaMEZ9Z/0FWFxvDC2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314618632"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="314618632"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 21:38:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="785150699"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="785150699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2023 21:38:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 21:38:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 21:38:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 21:38:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPyLxEt70SVqcglebM1Ktpcsm32dn25Y+L2Mr9o0qhToU+9DkyB5pBgGjOaM8uVs3ED0wNMxdt1XplEi+D1kFujqZTxsw1+Or20FtnBMMzZPIAFSW6dFHZTJ0hV6Z45sP1GnXCEsY5/wZG3A8nWoeiodrsNENTuYyKjDoxmh1TU586h86dR7lOLqUDaXvBNrscOdgCeFyyE1RngE/Ib0VlU3imSJd5NktOoopFVB2A5oYkmXdihCEzVw7T3L3CiEzuaVdrGxyVQuXxUcXpKkd+aUWcFo42uFAREe56bUIz2kZ+rfHGEH0reBDVRbWA4hZGqPRZ/c+e5fk0WfKsUoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oczNGZT7nmCK0v+MvsyJ0mRRuOISTTN2NbQ6w9bDWqU=;
 b=co/CS/ip73cor8HBIvfwAOccT8CP0J5SW0VzbGzaPe/pNXSx2G6wjI6yCy4YRpP78hEskjWntK28CBZF5/Vj/f7iMPKFc0L6qe57sGoQf/1q8KhUdrzqFq0YJepepSgeaV3tVw5mFazjoTGW/RXjT5mkRZd5uM06nTKKqTJqij2N2N2hzBzxRuJvwD/+aU+QzOnk5JflG293NDTwrUeudzW4JtdhqD2yBlptnd105omySCIMbFJc/fjH37YVf40uSUMNW4W8Z3p7xlyWsGzXqLIYyBXkrWyvLpZ2r8y9rYHu3iwEQTPd2tVAFZXa8cCyysllbApFXhXtY/fB/dCuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Fri, 3 Mar 2023 05:38:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 05:38:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Thread-Topic: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nhycAgAEDtGA=
Date:   Fri, 3 Mar 2023 05:38:19 +0000
Message-ID: <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
In-Reply-To: <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6336:EE_
x-ms-office365-filtering-correlation-id: 878ecd54-d265-4680-3164-08db1ba97eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mReVZczkKvlcWb0I8tmOfK5MbSa6lO+/htcCJGxHCCBSCOtVeQB85yoIlH3mnbBQJ+/Kml+0CoxuekghH4PICy3SOPa9Dxy2Drf7UKNQNQYtpoEHErvONIxCZguMv5oqAaj0np013PaleELFMhZzuaClzhOaCyOM6jdll5UtOM4gBcKO7rzsHN8SA3JSfkRHFH0MAiEM/+s9qEhpEMN0jqTlblrmUy/HXkeYVc7HPg3RHzsAC356QHSr8iFvq3Yvgo20t5prQEqaAYhAIqiVvQBQHomQBhkrlLr1DBDZvAJaegJjiqDdEDs8OTz35AZ+OfzPEsFdNmJCQhIkO72zlnTDK8mVIluOlxg4koPcWf1gVdsVi2R9xZLQDUUF3L9SXO+L1p/HLaYDV54SMy0XL8iYgbVYdPg4CbTLFDIYEMSsYsUAxBRip/vmKE0FFUtjXRXpPqiPyvec+pQCwV6S52PU4aI9lsN2ecF56kX2f6Dw92Vz9ItBqE/+1cbkJnIPCYhZdp+V/yrRun7xZXz1EQZKJsVlcrerxSg0uJrclUT/UJ4yBsAUDnAAPsAxFQoDADExWxtERgl6qmlgj0JKhLYnYjSnxZ2YyzYo4RBdLEBLpiCuUU6/W/wFZaBpIia/wUDs1RfwOcZf849zO+nGHzOj/WaPfoyKmwjNdNPnnkYL6iAzabr51K2yto2UpSMlunXEB2E12Wrnr6iKE6QKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(9686003)(6506007)(26005)(186003)(86362001)(33656002)(38070700005)(55016003)(82960400001)(38100700002)(122000001)(41300700001)(66446008)(52536014)(4326008)(66476007)(64756008)(66946007)(8676002)(7416002)(66556008)(76116006)(5660300002)(4744005)(8936002)(2906002)(71200400001)(7696005)(478600001)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTc0Ulp5US9nSWYwQzIxVzNMU0VjcDN0dHpReEZnR0k3Qnl2K1k2WmNkWWxW?=
 =?utf-8?B?SitwSVhQREpoaTdZVzlTQUd1eVh2QmVXMXhPMFRmZnExakRhWloxMWdTd3VV?=
 =?utf-8?B?S2Q0QVFmcFdPcVJQWm54RmNNMXVQbGNrdk42cHNXMyt5S25LR2EzZDIxU0lO?=
 =?utf-8?B?ajZkNjRYTzR4UTFrK3Nnd0J6SWtuNzBvbE9Bd2F0My9TRXhTa1lnZ0xqS0Zm?=
 =?utf-8?B?d3JVL08zQVA0WHpXQzJpbnpLaUdxSytVbFc0a1dqMTZzZm4xY3lXbDVLbDdV?=
 =?utf-8?B?aU1VM2Y1RVRkMVF6d1ZYT05PbWFSaWFZVTNaUktlaW81cVlUeE1idWxkRWJP?=
 =?utf-8?B?eVI2aCtoL1ZlMHlVaTNwNU0ycHZwTzZSYlgzeTdra1BkNmlsTEk4eWpLdk82?=
 =?utf-8?B?S0ZIUFhCQXQ5a1BqTTNodUQvSzJiTFNDRTVNRFBPZk5wWEtLMzN3aTN5OVNT?=
 =?utf-8?B?Y3RTVlhIU1NhU2xDeVJBS05iVGJHU0NWSGRYbDFwOHE2dDh4bDN6T2FTQmE1?=
 =?utf-8?B?a3o2cUNtcUpjcjRNQjhhUDhQVDVmckwrcFdpaUtieG9uV1NNb1cvVjUxSDNk?=
 =?utf-8?B?NmxHZlVvWXNkT2ZLdFd6ZUp0aXNyd0tueVNWaUExV01tL3c2bjlBamZ2REQy?=
 =?utf-8?B?RXNCY1llUUs1VzZNUTN1ZmhDWll0OUFSSnViTE90MUE1ZVN4SW1qdkwyaXQ4?=
 =?utf-8?B?YncydU94Vk9EOEx0dW90L2Q4QzkxYU5kc21OUytHUHdjZUNOOGJPRzhYZlln?=
 =?utf-8?B?UGdjOERwUmxuRGJTNzlmMkRDQnRHV0lmVnp0VGk1RjlvbzZXUnBJMC9UaVgx?=
 =?utf-8?B?ZjVCVHNIUldpQURxMVhmRnBGRGoyZVhsbXUzdW54ckN3cktXc2pHQjIzeUI3?=
 =?utf-8?B?cm1xaHZjRUgxVS9lQ25LUXhQQmphYlhNVGN2ODlDLzJYK2xRdWJTcDZEVXNG?=
 =?utf-8?B?cFpuTkJnejYxK3hjdVltQnNqTTJ6QjRmS0ozTS84U3h2SGZDMGMxRDk3RlpO?=
 =?utf-8?B?MVNpMjkzVkFmVzBTRDNBd2pnclRFUXZXS010R3lIcStIdEJWaWxqTHgzazY5?=
 =?utf-8?B?SDFOUEpEU1ByaW5CZlEzZ3Nqb1FmZnJIdnF2Z08xNGR2aGdMQ2QxV2pLb1dY?=
 =?utf-8?B?U3QvcTZHby85OTBXN3ZVTzgybm5oVTRuK3l6dDgzUEVxclQ2S1M3dUZNMUdT?=
 =?utf-8?B?cEI0bVFPc0NndzNPUzBOYUR1VHRmNEVrV3hnaWVxQmhhbzlvSWJLa3c4cGlX?=
 =?utf-8?B?TnFtZ1FOcHhhRGEvS1k0VDZWVzM2cERYSFJIZldnTlF1aHczK1I2VTE2ZnA5?=
 =?utf-8?B?WUpWZmYzbzhnOU1pQXd2VXk2Vy9xcUxCdUF6em14QTFvYWI1cTg2VmdJSTFS?=
 =?utf-8?B?M0NldVBRVXp3Ulh1U2YrVHU2RWlXV1pFTWFZTkc5VXhLVWtsa3MrODBoUXZG?=
 =?utf-8?B?d3pJd2FtOFpTNXo4WVlodElXK1pydHRteThENnJhZGtBTERtOEdCVEpLTnV3?=
 =?utf-8?B?YUttQlJwU3U1bDlRaGh6NGZPREdjcXFYTHBhcFY2TnhwWGtTaDNlUEtKUmtq?=
 =?utf-8?B?ZWtnU05IdGphbTlwOVFWYldCNnpsSUNtM0VGbHBFRWlZZ2NWQXhrM0RNZ01m?=
 =?utf-8?B?L2drV0hkK0szbTVndmVSZzBMQ1IrSkNLWFVONDkyOVBGUnNtM2VRVVczYmN1?=
 =?utf-8?B?cDV0eldLbW4vVFkzd05qWXVuT0hHd2pQbzZ1cGRaTDJ3ajZ5VHoxSVBqRFMv?=
 =?utf-8?B?cWFub2E1Vi9jV3BkQjlielh3VVhFMWpCSEZFQlNsYVVoaC9uZk9TeUVxdkdE?=
 =?utf-8?B?TmQ4VXlJNVcvNlBSeGFYUHVGbVZMWndzamhqa25GTmZ3WDhVMktSb0luUW8z?=
 =?utf-8?B?ZzBWcDc5R3d5czdZZU9jcDJNalJ6VWlGcTB3U0FPK3NwOGRCTTh4UjdCSUtP?=
 =?utf-8?B?eFhLNUVwZ3g4b21qNHF4cm5YTGxyL2NUQXdCVmZWRkFoNGFxSDRESUhwTUZT?=
 =?utf-8?B?NTN1UW9NRGJreWNYKzRaR3RDR25PdHhiZXNaS2g0M2hiN29FVGxiZjJHNEYw?=
 =?utf-8?B?dXVrQWhmQ0N2TWV6dUp6TmJnV1ZIallhUWp3dGtVZE5VcVpoTmVOemtXMGR2?=
 =?utf-8?Q?eCaiBLdXDNV5/AtJ+EZHNsHRF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878ecd54-d265-4680-3164-08db1ba97eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 05:38:19.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyBx34In0K/frWJy/+74p2zlrw29kskRz2s5vbQkBBIApVJukLHafmPkk6V3reH9FYJ4ArOEXqHPI/jZMyEBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMiwgMjAyMyAxMDowNyBQTQ0KPiANCj4gPiArDQo+ID4gKwlpZiAoaHdfcGFz
c190aHJvdWdoICYmIGRvbWFpbl90eXBlX2lzX3NpKGRtYXJfZG9tYWluKSkNCj4gPiArCQlyZXQg
PSBpbnRlbF9wYXNpZF9zZXR1cF9wYXNzX3Rocm91Z2goaW9tbXUsIGRtYXJfZG9tYWluLA0KPiA+
ICsJCQkJCQkgICAgIGRldiwgcGFzaWQpOw0KPiA+ICsJZWxzZSBpZiAoZG1hcl9kb21haW4tPnVz
ZV9maXJzdF9sZXZlbCkNCj4gPiArCQlyZXQgPSBkb21haW5fc2V0dXBfZmlyc3RfbGV2ZWwoaW9t
bXUsIGRtYXJfZG9tYWluLA0KPiA+ICsJCQkJCSAgICAgICBkZXYsIHBhc2lkKTsNCj4gPiArCWVs
c2UNCj4gPiArCQlyZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUsIGRt
YXJfZG9tYWluLA0KPiA+ICsJCQkJCQkgICAgIGRldiwgcGFzaWQpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiByZXQ7DQo+ID4gK30NCj4gDQo+IERvIHlvdSBuZWVkIHRvIGNvbnNpZGVyIHBhc2lkIGNh
Y2hlIGludmFsaWRhdGlvbj8NCj4gDQoNClRvIGF2b2lkIGNvbmZ1c2lvbiB0aGlzIGlzIG5vdCBh
Ym91dCBpbnZhbGlkYXRpb24gb2YgcGFzaWQgY2FjaGUgaXRzZWxmDQp3aGljaCBzaG91bGQgYmUg
Y292ZXJlZCBieSBhYm92ZSBzZXR1cCBmdW5jdGlvbnMgYWxyZWFkeS4NCg0KSGVyZSBhY3R1YWxs
eSBtZWFucyBwZXItUEFTSUQgaW52YWxpZGF0aW9uIGluIGlvdGxiIGFuZCBkZXZ0bGIuIFRvZGF5
DQpvbmx5IFJJRCBpcyB0cmFja2VkIHBlciBkb21haW4gZm9yIGludmFsaWRhdGlvbi4gaXQgbmVl
ZHMgZXh0ZW5zaW9uIHRvDQp3YWxrIGF0dGFjaGVkIHBhc2lkIHRvby4NCg==
