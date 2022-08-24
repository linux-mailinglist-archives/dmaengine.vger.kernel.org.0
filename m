Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC05A0327
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiHXVMQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiHXVMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 17:12:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74C7B2B6;
        Wed, 24 Aug 2022 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375533; x=1692911533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P0LBF7bpre3c6x2dK+Fdw7akCC71QV9sU7IKswrxAgU=;
  b=cDB6GKzIVQrsIqCotSQQhAb6XRln8JZAeo4Fo5+thLyctJvEnhukFNEv
   tFOGivMHy8H3YZLA81JnW5vwSE6z/1qKG/b7NrdMp2aC/5afM0+FVXJmG
   rL1dZitTyIqgBT0eSB3E7jQex2bynv/DdiVLiNVpRByCcn4r/bQkYR6hk
   y+qjQmaVF/Y5EPVdWBqGK167ubwBed8DvEQE6Qu765wWmL2R6G0YS5KIl
   VrfE/uOoRpylvX/U/hYB4OUmqtNpn7VWmpDRfY/U5X4JXo4MzgbmhGkpg
   Nxk8PpOv18Uy0b8tbt/IywW5uKjqBtdvKo5BXPVlgrtc4vevs5xo++Jyy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="320147072"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="320147072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="670681071"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2022 14:12:13 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:12:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:12:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJriDUNy13QlcAPiNAihMDTKp+Dl1TH5IHdv/Pkt0ESldleUHyFisCoxdmXI7h2ZMUAzItB7+0iLeYGX+hMOJ7y6rdk8m+rOwjpu9Bdy/Qkc1wGNEWUNSfBVBOk60FofdoFADhFAQNQmrVKtn1FEc7eAk2OSZdoFlhLip5FKWLboXSmK/HGKvtnruaSX+lzK0YLM4ecXePowwz+eQqI4kzAqhZFzZzxdCWPHcybkY6zjXEp+qJXCwdAQP9NlORzX930HmraxMPO927e420B81kMfY6qehVFjilHD0BrmlpmyPRC1MleQo7fIGViD8Vntbp3UYWUIgU0xq3JVZoduqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0LBF7bpre3c6x2dK+Fdw7akCC71QV9sU7IKswrxAgU=;
 b=fN/jX0/FsnjNEMHrd5Lwe7ttFrc8fGcHZ+8btsMYLmxb/MWQ/zjsTPsfxnDjkcGgMmttSlh2tjdIWH1clDpgHugp9V3+7VBjSeWA8QOXL2wV5GG7ZJlYgpqzgelK2KvLuAe2hx0vWt8C/MCw7n5Czn6bXMTXPTgnveSwFDhc1vnfCHkFkcADJ27zuvmO2mzTyd6gTYpZSKUD3iEFhQWt97b9KA9BsdHVlMkw4YTD32t+BhzxFdbJb/Ten90j15tIFlYOpDsra8Awq2S8uCA+IKdwQFuyzJj1q22C23LFJV28tYVYbL0AiLysuuD35Tw3HjNNX5CEqKKyyeyPXQuTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BY5PR11MB4353.namprd11.prod.outlook.com (2603:10b6:a03:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 21:12:02 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9445:c90d:e4e9:3bcd]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9445:c90d:e4e9:3bcd%4]) with mapi id 15.20.5546.018; Wed, 24 Aug 2022
 21:12:00 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Thread-Topic: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Thread-Index: AQHYtw6fdfvRhnZMqEGTjt0oQRMrOq28sZ+AgACIa4CAARpogIAAD+GAgAApfaA=
Date:   Wed, 24 Aug 2022 21:11:59 +0000
Message-ID: <IA1PR11MB6097988CC9C2C1C713E3D8339B739@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
         <20220823163709.2102468-1-jsnitsel@redhat.com>
         <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
         <20220824005435.jyexxvjxj3z7tc2f@cantor>
         <223e5a43-95a5-da54-0ff7-c2e088a072e3@intel.com>
 <38e416b47bb30fa161e52f24ecbcf95015480fed.camel@redhat.com>
In-Reply-To: <38e416b47bb30fa161e52f24ecbcf95015480fed.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4093bd-de0c-4e27-931e-08da861548cc
x-ms-traffictypediagnostic: BY5PR11MB4353:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BswJDUX4hAKUcDi7+GZ9/Zd433zx8zfr6FN4htTlMVkpJ628aPXvLZWbR7c826x6/q3nr6oV6oX7qwxQlERvYk8vVu6m9lAk/DntfMPyBGEmJUNDbSERBvPLZVfMyT8IYatkcQoXB+cVNajgpuqLhsXRtPy5jRWGDXYUb6kcpTaNvnbrXfWWJyixgbUTKijubfEE/eHIWl7gYUcw0uGRW2ziNDDAgKODvnVT5xxxhZTFPAGU+XGIeR1dFtMN7OUHTBnc9dLPU2qTdftqicMfA1OiiLTz1mIfpPtuaujJxaB3/Z3rLe7ooMwZ6/VKJ5RqulPsUKiPAiKXXfIbhZjbmI3qDxQ/UQxl+6fXC5u8hNhWio7weVEvK1i5QhsSEP48NTJgKaxH9bHl/YJAiYi0xJikrnpoBrizo0vzJZGNtBQYXh1kxdEqIHkxf0E4feKldXAbjeeJkb1GoxdpZd0Vd5eCIc5cSqJxETz+rwADKk35GtlObJd1R0lv609/X6LqL8+g/zjPZqrV1d+4cQX5oQGjRczz9BtGtrzxgqasaunmeIqGkrGAc0rBhIw2Yq7MEVqlXjZcdwXGcPaj1NiuHWPbJSFnqKLeWuAsgiKyU89zMpqT/fJupS+Z0EmBu792HCKt5FnmiijiN6UvbuUK/e+0KYk7wOcEgf/PeZQXzpAfBZ+gWA37bu9O97E7vr3bIvZQw6EeiTIgjsj0qOgxJApzHXBFz/MhbCpwQYoilihNZya1APmqNoH0vUOfCiaPFzgrGw+pwQWlBP656XdzzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(122000001)(52536014)(33656002)(71200400001)(4744005)(478600001)(5660300002)(2906002)(86362001)(64756008)(66476007)(55016003)(6636002)(186003)(110136005)(4326008)(8676002)(8936002)(76116006)(66556008)(66946007)(66446008)(38100700002)(316002)(54906003)(38070700005)(9686003)(82960400001)(7696005)(6506007)(41300700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REFST3hWbG11ZjN3a09tczJlWUhuejNUWmREQzZYUkJQNkpRN2RsMTdEMzQ4?=
 =?utf-8?B?ZmRpU243bTgvWGNPZ0k2bzdiYm9XUGxQbHd1TU5zckZNZi91T29rZ21vbisr?=
 =?utf-8?B?V0JUWkc1Tkx3akY3SzIwTHRPRitZQ2FKSFJNdUVNdG1LWmQ1TzVuM2h2RW5O?=
 =?utf-8?B?SDZ2c0tXblhTb1A4MkhBTWxqbTRXazZOWmZ5WUUyY0tFWDlENlVMMUl0ek9l?=
 =?utf-8?B?VFdRNXo0SkJBLy92NFJkdENFUVA5RkZUSnovREU2Y2VoQWsyWkRkOXpwS0NZ?=
 =?utf-8?B?NWlEd3JaazlqM0xoV2pwQ2tTM2JUckZwNzV5SHJ6Und1RDI3NXBLQStxMHNo?=
 =?utf-8?B?cVNiUmlKd0ZWV2J6Y3FQRG43enA3MFhQNktGSGNGWVJ1eW5GVEMyTHZWNmZQ?=
 =?utf-8?B?WG9CRjNMNCtucVRISWU1R2tUY0l2c0JuTUNrYVF1eDdubmVuUnZGaVhuZCt1?=
 =?utf-8?B?a05yRnUzOXhMVWpMVUUwcGdWWlk0RnFEZHR3ejZIK1ZqSE5XN2dVTmpOMzhP?=
 =?utf-8?B?MWtMMnlyam5XWTB6cVhxUS9ZMFpRVFJyb1hwdTI3ckZVV0xveG9rMWd6QkJm?=
 =?utf-8?B?c2hlR0Z1OW4wcFhHbzhSTzVvVlBSbmJnQ09OMFJ0NER4UUNwbElMUzBlT2gr?=
 =?utf-8?B?Vms2bE1rOGNHaFdXN3NUbHc0VUZTVnJ2bmxwcUZvZzNMc0FCV1RzRlEwU21N?=
 =?utf-8?B?OEI2MHBKdWlhRWxmbjRIS0NNd2c3VHAxWnd3alYyWDdrQlF4VEZzeHRPcUpW?=
 =?utf-8?B?SWR0MEl6N2Iwa01NRlVNbTZlSS8rWWtaUkM3UmkvUlNUM0tGc2ZSTHBUYmtQ?=
 =?utf-8?B?b2dBek9xeEdBeExKMGFzTGo1VHJLSi9iN2Vib2I4cDJ2SGFiRVVNUlc4R2tX?=
 =?utf-8?B?bmRDNmgweDZjbWtEamxxbldTT1pFUE54eWhPVXRzdXBZUzV5d1ZhMmNVNnpL?=
 =?utf-8?B?dksrWkRhcmNIQk4wRTFmdW5yeGpUT2VGZWVJN3d3dXFTSGNWVmNtK0xENDlP?=
 =?utf-8?B?Q0JabVJuaEV2STdFOFlXTlFmdjVnWm1SOG90Uk92NlpmK2luWlVKY1pZQ01n?=
 =?utf-8?B?TjZZTmt3VEFEeU5LeUIrK29XUy9sdmJ1Skpxa0ZiTWhxMW9DRFRqRkNhMEdu?=
 =?utf-8?B?TUZCRnBKQnhFd2JzSDA2TERKTVE3dHZIZUk2Nzl5bFJnb05lWFhnZm82QUFD?=
 =?utf-8?B?c0J2M3hxRk1pUlNrVDhWSXp6L2hjTzlaRm5WRVZoblBLMEsxOU5mVjNqczdV?=
 =?utf-8?B?NGlRTVc1Zk5WVG5mY2p2M1U1V08zSFZQWHI4ZERucS8yZ2JXV01RQlhnZ3J5?=
 =?utf-8?B?NEUxV2ZPeG9PWGJSazRFaVlrcFQ3VVpGQ29SV2dmMktjenMwUGhYbHhJaWR0?=
 =?utf-8?B?cndZZllyZVUrR2NmU2NCQ3FtWURoV0M2NWhtN2tYOEp4VXQvWHZ2TEFTSThM?=
 =?utf-8?B?NUNTaFZQS2FuVlFDK3oyenZkK3p2SXA3UTVLRjR2ZHA3UzVxMzRLcUEvbW9K?=
 =?utf-8?B?ZzV1bURlT1gwSXRZWjB6M2dsOExVTy9uQ3JEYmdZYXdMeDRWRHNUSWkrMjMz?=
 =?utf-8?B?Z0xBTlF1TUdNL3VILzczS3d5QTJMV2o4QXZPNDIwODJIbDlrMkJuaExkNmR4?=
 =?utf-8?B?L2RPcFlxMGZTRUJUcUhhYVFsQitQbTNJNklYMVFnUEgyR2k3dGlHYkdyQmdz?=
 =?utf-8?B?MWZpQitQNElXT3dXTFpoZFhvdit2Q0FFUEJ6bjBWMnJvZGhSenhiV2QyZWZ1?=
 =?utf-8?B?clprYTJuUjI2NEFOU0M3bEgyWWFPVE54eXFwOUUvVi81aElIOTRxOXlKWWYw?=
 =?utf-8?B?YldVVWpyb3dKeVUxOXY2M2RZM0R1YzBOdGpGMGVIaG9HYUpWVlB6bUxuSTJz?=
 =?utf-8?B?Zi9VVFdVUVI0dm52Z3BVWERZT3BBa2RmeGhwdnhvOVJPVUdzOXlSbWxiZFJn?=
 =?utf-8?B?bDlhazQydkVTa3hCajRlaW0vU0Ftc0VrZjB3WktnbmhoYVlPejB5MHBwY1lI?=
 =?utf-8?B?K0hnSFhBRGxqTVFmSEhTTEpnQW1IK0ZVTnNsYU9kR1EranVQMmwxTVVZYkRs?=
 =?utf-8?B?Nzl6R0dDZ1N1L0Y1NGFtbnMxT21oZnJWbEZjWXNKd2VIYzNDNUF2MkhpbTZu?=
 =?utf-8?Q?bZnHLMFPu2bHr96kMDdffHrvr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4093bd-de0c-4e27-931e-08da861548cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 21:11:59.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NadijZc8fVmV7vaV2FUDWPHa8o604BIP12zj3WfaUliHgQIGlrs/etBKA10bn/Vzzw9l77KXGaA4u28I+vGgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIEplcnJ5LA0KDQo+IEkgc2VlIGFub3RoZXIgcG90ZW50aWFsIGlzc3VlLiBJZiBhIHNvZnR3
YXJlIHJlc2V0IGlzIGF0dGVtcHRlZCBpZHhkX2RldmljZV9yZWluaXQoKQ0KPiB3aWxsIGJlIGNh
bGxlZCB3aGljaCB3YWxrcyB0aGUgd3FzLCBhbmQgaWYgYSB3cSBoYXMgdGhlIHN0YXRlDQo+IElE
WERfV1FfRU5BQkxFRCBpdCBjYWxscyBpZHhkX3dxX2VuYWJsZSgpLCBidXQgdGhlIGZpcnN0IHRo
aW5nDQo+IGlkeGRfd3FfZW5hYmxlKCkgZG9lcyBpcyBzZWUgdGhhdCB0aGUgc3RhdGUgaXMgSURY
RF9XUV9FTkFCTEVEIGFuZCByZXR1cm5zIDAuDQo+IFdpdGhvdXQgdGhlIHdxIGVuYWJsZSBjb21t
YW5kIGJlaW5nIHNlbnQsIGl0IHdpbGwgbm90IGJlIHJlLWVuYWJsZWQsIHllcz8NCg0KQ291bGQg
eW91IHBsZWFzZSBkZXNjcmliZSBob3cgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZXMgYW5kIHRlc3Qg
Y2FzZT8NCg0KVGhhbmtzLg0KDQotRmVuZ2h1YQ0K
