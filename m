Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3D6D23A0
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjCaPIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjCaPIo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:08:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06E44B2;
        Fri, 31 Mar 2023 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680275323; x=1711811323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qmJLKxPmPmtH1V36CRitpYLNMv216+TzK/VnJCTSNiM=;
  b=J6t8LdOi6AuXyVEiov3AmEIhKcvAtFVN1jdH+ejjuHdi8NPQz8/L+u5r
   PiXrKU0JNyjXcF0Yw9L4tyZRRDzKMQZe77E46QkwZunzYlxqBuEq8iQ6u
   kmurWAWWdeaiAT4DDokd/4ymlKMFjdP3T5VoT2G4lBvOqj5ekCVSxqDyK
   kXYMU8Sjgr+uoVLFDWPJF4Zd/r5VZQG6XETMM3EJ1YfCXqkdjrz84JtB7
   Em7VA+309UeJeRRc6Cdojwb6cYqOp8IKc9X0F4EPyqETT2DdbmfgnfDDJ
   0RICn52xxorfAfiz2qTFq+PlkcyXeeomHj7oGK2VQyCTpI3rHNM0l1GLc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341485296"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="341485296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1014854732"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="1014854732"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2023 08:08:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:08:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:08:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 08:08:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 08:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+/bqhDa9d0MRQsWtWCCN4XyJLSQS0JRxzF5bBB+oCb3b06/SRunUDJDuHcjKmp4sX+7llGn3L5Ra+1+900o+MQhqH5Zc8ydQUT7NdWcsfaMOEycAX5Q34kZfj+7F+migXdbz9dVYeIvlDF+lAUFsDRVa8lDgS1evrD8yBgyb39RXnxcly8NfigQNoA1gXKbKTrq9geyb9pmqACPpl5tKKuWiG4JdWMskjZvYOaC9Wd++QO5NY8z83J0nafrSPGk2WqiqHmEhbkQoi2CGD7qKuH9xc4CRt+AixavvH0Gd5zdZ5J1WSCMXCPLjMNJoE28aSY0IT2+JGLciE181oOXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmJLKxPmPmtH1V36CRitpYLNMv216+TzK/VnJCTSNiM=;
 b=lSw58e7FRc1wBmi820Y1DOSCx3F+JqVcQkA22LweD7QFDQr+bw3AUMrLKJlzz5LQiah/8fH461ka8K1fmrVPhiZxvrWv1ctP9kKib9jkuJhRt07yvlbnLXgKiUljWmH+m8cUkoQltnJGa3KIQj0OpwNiBAPcFT0v1uSV9DHh4PAEIWGHH5Djn/gr9YyPLTjaTX/o8PBIS7hPddYqmSRMDB6QEfkrdWO/RigYumBtv1z1bZBwOnqCn9GF96htZqBxLruECf33RITH0QLI73TjadnHM0IBoGb4y+PWFnib3Bn1eR2VPE8kKVMigUUtp1Y0UJJQUCmQLFVxYeRqZqqmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3051.namprd11.prod.outlook.com (2603:10b6:5:61::31) by
 IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 15:08:39 +0000
Received: from DM6PR11MB3051.namprd11.prod.outlook.com
 ([fe80::1e68:9203:24c9:ab01]) by DM6PR11MB3051.namprd11.prod.outlook.com
 ([fe80::1e68:9203:24c9:ab01%3]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:08:39 +0000
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "Guilford, James" <james.guilford@intel.com>,
        "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
        "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>,
        "Murphy, Declan" <declan.murphy@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3] crypto: keembay - Move driver to
 drivers/crypto/intel/keembay
Thread-Topic: [PATCH 1/3] crypto: keembay - Move driver to
 drivers/crypto/intel/keembay
Thread-Index: AQHZYYuTh79ESf5bUU2MhIfFLNsVia8VAj+A
Date:   Fri, 31 Mar 2023 15:08:38 +0000
Message-ID: <35d9295941c7063d40cdd67e3912e6310f808a41.camel@intel.com>
References: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
         <20230328153951.126564-2-tom.zanussi@linux.intel.com>
In-Reply-To: <20230328153951.126564-2-tom.zanussi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3051:EE_|IA1PR11MB6193:EE_
x-ms-office365-filtering-correlation-id: fceed52b-61a7-400a-01b3-08db31f9cec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZwhRIDXCVzYUgmjWHxIECbIAPwgMH8GhT7INwN7q+N2HERksjBefBg/zxUmfIiLZDyZiseSgzW3AIsnXHZFhZXJZ3TmuhNzuZPR8H3I7vSTRCIemeCPM8Zc3uezbTDtqIkdw2w5EhpSHCCBxfv+Ng/XfJmmL3w08UbNqK3O6xdlxb8oGEA40zszlyVer8k88ul3vKlOcR81XjyyzlnVx3JAnyqNdT1EXt+R8qtCO8mcVKM46puIhS6B8ykGFjhbk/aHvxr64yt66YmwlTRJEGFsuhvlxnDXNJcdEq97HqyMBPMQvkrTJhqwizVokJRCX7K1gypTTQTFPr1zwB2mFthAy/q67Ti2ch3ahSA7XPrRNlPju0w2o+2E71nMfvCTE6SnSUW5o7ELHNKLASi1WWFN8TmDrSqpFTzDXskAdQqP0d2hSpIlIiXODYRK/qUk9eMl9TmjoVJOgW6AttuLEjE+3y2cw/mnrVJA23a6Veb9ivDGzYgUQawe4JwXXTVouJNvFpZJfhTZNLAtbSJzIRy5jtzUU4ODwH8v2xuyRjZbT6bq8E8toPTJVsjcYgCmC9Kc7s/uCEjk1xe6bCYAAykxOkN8Q13luvdM3yhfw3w0n50z4ZEPblnwIBvI666C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3051.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(83380400001)(36756003)(2616005)(186003)(6486002)(6512007)(71200400001)(86362001)(316002)(478600001)(110136005)(6506007)(54906003)(66556008)(41300700001)(4326008)(82960400001)(66946007)(76116006)(64756008)(91956017)(66476007)(8676002)(66446008)(122000001)(8936002)(2906002)(38070700005)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFPZVJzWUZFc0tFVndDdTd1TDdTVnJ4WWJ3NzFvNlhGQlRjc09CTlFIQk15?=
 =?utf-8?B?L1pwSlBCdnlkTXh0TlNrbE5sdm1tUmQrdG5haVFSaTVocmMxR0NDNzRUb3I0?=
 =?utf-8?B?eVFoOElsbVQxNWtGeHlYNGxwbVVvRnIyNTMwR3Z6cUF0TUE5SFpxbEVXUWZJ?=
 =?utf-8?B?S0dxNEVhd2tkdjBLVVZNR1JYWUtqU1RsZnBlSXczdmdNZTh2K2xFclNDOUJs?=
 =?utf-8?B?Vk1OQkRQeW1SbHV1Ym5pbHl2TnRhZHZVaURDSVZmQUh4Zks3b0c0SkV0Z1Nu?=
 =?utf-8?B?NUlvU3YyZzN6ZzJCRlo0NThibit0SVFsRjkvSXl3aGJ4MUlnSWdlS0VXaml4?=
 =?utf-8?B?LzJIVzNLRFFwdDVlTjBqNFBrV25QK2N3bVQ5ZzkvdmIyZEliUThjNXgrVUlZ?=
 =?utf-8?B?Q0JwUGFFVXRzVGJEd2MrQlcvQTAxaUdTdnp4WjVCTUtTcDAxeC9qQkFJWlgr?=
 =?utf-8?B?bHByUGpYOFMxRGtLUWRrVjJlcFdJZlM1elhGTVV1N25XMlNvR2RTZ1N3SlZ4?=
 =?utf-8?B?akw4VEE3L2d2UjljRkp6cUxMYTNoYzR0cG4zT21Vc3l1eE1oTmp3SUV6OTdB?=
 =?utf-8?B?dTcrTnhuMlUyVndBUjJkMkN2ckIwbUwzYVg2TDY2eTZ3aHlJb3JDZGlZRlN0?=
 =?utf-8?B?b2laOXU2TUFzMS9Gajg0RnpBTnI1UWdtNFkzWit5bzZBVnVCU1BIcS80a2J2?=
 =?utf-8?B?QmtyTkJVM0Fhbi91WmFveWsraUlzUGIxWTNLVjFmeTd4NDdQWTY3b2dadk5W?=
 =?utf-8?B?aU1waTRzYTdIcnVlSWRFemRXaENaNXFtTzdleXBJMS9JNWcrcm1aT3QwbXhO?=
 =?utf-8?B?TjNkSkN3azc5WlFnU2JHRlQ5SUNMSlpHT0Q2KysreG5CTHZNTHY4ZnRwWlhL?=
 =?utf-8?B?cFo0ZldOU0RhU004QVVlRXY2cU9jTGhGNlN5QWNvRnlhWVVBZlpmbU15V0FX?=
 =?utf-8?B?NnROMkpaMXVaZVBaOXUxcVhXd1RLYlVDQnBUNjNTenByY05yT3UzNTBwUEVS?=
 =?utf-8?B?RmErMElubFM2dVlXSVEwYTk3cUs2WHArS3l6TzRtdzlLbXZEdEh1eUxwR1JJ?=
 =?utf-8?B?N2daeWxua0pLY3FMZ1FobUEyUjJodWlhczEyVGNhYnFZSmkrMTVzeXYvdE9k?=
 =?utf-8?B?bUJ2L0NhQW9ENXAyS3FNTzJmYWxUQm1rMFFVZ056MTIwWHQ3czhWWWF6ZHVJ?=
 =?utf-8?B?V0JPUXVqTlc0V01DWkRYZC92WFQ0akJVMWtHQnNRSjNKNnFNNkpaeUxCaG45?=
 =?utf-8?B?VDNuQm9IbVBQeFlTM20wSmppS3BCSWZCTFRYTEd5TnVaZkJnaEZsOTNaRm1V?=
 =?utf-8?B?RzVJK0JDVlNnU3dZR2xZZVdSU1lrdS9vRFNlUnJYSUU5RVYreG9KNGhIeXJk?=
 =?utf-8?B?VDJscFJDNDRBckhTRWRmbndIOXloVjFVb1B2bFZoYTJRN01pN3plQU1SN1hC?=
 =?utf-8?B?Wkhvc1hxTFM3SXVFS2ZJWmxjSC9STmhwN3BkbzBoM25UV0JLcG95RHkyNUpV?=
 =?utf-8?B?K2U2cWE3UmpkZ0tnMmpjajhRaEpvOTFjYjdjcHpJVC9WZUthTW81azlqY1I5?=
 =?utf-8?B?cVI5dVBVMUVnSlJYNjZSNEhKQTRVZUg4SmNIR1RyZnMvSmgxeFFJVHRueVg0?=
 =?utf-8?B?L1VtblJuN2lMdEZQc2YxZXZncU1jMlg3RzBkS2pYc0F5RVg5RWJuME9GRjhV?=
 =?utf-8?B?RlA2d1ZaSWhlWWY3WGxBSDhYMnNXL21nOFJiQW8vaUZQWjhqZ2QxWkU3MlNL?=
 =?utf-8?B?ejU2U1IzWGdPTjZBMlJYK3hsOUJwNWtGdDZUM3g0S3VIV1JoZ2xxbXJPS3FD?=
 =?utf-8?B?VWJ1WGovK2VGMWhRcmNrWk5XK1VidXBudEJiblBNSnVoWTlITXV3d3RlMTlZ?=
 =?utf-8?B?blpjemw5UUkvWFlKUmJpTk5zN01LYStGYTJNYTNTK3VraGxOQnR2eTJZb2RI?=
 =?utf-8?B?Nno1TTRmTER6WGNQZHJCT1RxaHFBSTVsdS9md3ovTVdFNEx1d1pnUmNLNThu?=
 =?utf-8?B?YTFuMXNDSnRGVjZHNWRtTkhHcnJMM2o2RlIxQWdLV0t2bmk2WHFCc1EyelpR?=
 =?utf-8?B?aVJvZit3WmxuZFl6YWFGZnRyVkxkR1hWOElPMklvUXZ0eStjbkQvS094SVl2?=
 =?utf-8?B?VHhwRTFtQ0xZdHBtS013Z0ZtdVpIekdVaHJteHYwekJ2WXVTOGM5VDRiK2h1?=
 =?utf-8?B?dk1Jc2wrVlp4WGhEVGR1aUVhZDdzTS95Lzd4ZmRqVlc2YkpMUWRpczdtODZr?=
 =?utf-8?Q?7WCcbhG5Dqu3cAIhGo3iIqb4K7EKzEWf4xXzWuELRU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE5564F091170F40B2081F103DADF652@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3051.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fceed52b-61a7-400a-01b3-08db31f9cec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 15:08:38.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h21QDXYhx7WNhdZWoqAGvpMAobwrsFvOHgdZQoLWv4zK4OlZxKXkb9BQ1tIGZjzCWYnfhq7XkvYkvkYuPV1nTIovYuluX10PkV1S5vHPHIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTI4IGF0IDEwOjM5IC0wNTAwLCBUb20gWmFudXNzaSB3cm90ZToNCj4g
V2l0aCB0aGUgZ3Jvd2luZyBudW1iZXIgb2YgSW50ZWwgY3J5cHRvIGRyaXZlcnMsIGl0IG1ha2Vz
IHNlbnNlIHRvDQo+IGdyb3VwIHRoZW0gYWxsIGludG8gYSBzaW5nbGUgZHJpdmVycy9jcnlwdG8v
aW50ZWwvIGRpcmVjdG9yeS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBaYW51c3NpIDx0b20u
emFudXNzaUBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAyNiArKysrKysrKystLS0tLS0tLQ0KPiAtLQ0KPiDCoGRyaXZlcnMvY3J5cHRvL0tjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0N
Cj4gwqBkcml2ZXJzL2NyeXB0by9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0NCj4gwqBkcml2ZXJzL2NyeXB0by9pbnRlbC9LY29uZmln
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+IMKgZHJpdmVycy9j
cnlwdG8vaW50ZWwvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MSArDQo+IMKgZHJpdmVycy9jcnlwdG8veyA9PiBpbnRlbH0va2VlbWJheS9LY29uZmlnwqDCoMKg
IHzCoCAwDQo+IMKgZHJpdmVycy9jcnlwdG8veyA9PiBpbnRlbH0va2VlbWJheS9NYWtlZmlsZcKg
wqAgfMKgIDANCj4gwqAuLi4va2VlbWJheS9rZWVtYmF5LW9jcy1hZXMtY29yZS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMA0KPiDCoC4uLi97ID0+IGludGVsfS9rZWVtYmF5L2tlZW1iYXkt
b2NzLWVjYy5jwqDCoMKgwqAgfMKgIDANCj4gwqAuLi4va2VlbWJheS9rZWVtYmF5LW9jcy1oY3Ut
Y29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMA0KPiDCoGRyaXZlcnMvY3J5cHRvL3sg
PT4gaW50ZWx9L2tlZW1iYXkvb2NzLWFlcy5jwqAgfMKgIDANCj4gwqBkcml2ZXJzL2NyeXB0by97
ID0+IGludGVsfS9rZWVtYmF5L29jcy1hZXMuaMKgIHzCoCAwDQo+IMKgZHJpdmVycy9jcnlwdG8v
eyA9PiBpbnRlbH0va2VlbWJheS9vY3MtaGN1LmPCoCB8wqAgMA0KPiDCoGRyaXZlcnMvY3J5cHRv
L3sgPT4gaW50ZWx9L2tlZW1iYXkvb2NzLWhjdS5owqAgfMKgIDANCj4gwqAxNCBmaWxlcyBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gwqByZW5hbWUgZHJpdmVy
cy9jcnlwdG8veyA9PiBpbnRlbH0va2VlbWJheS9LY29uZmlnICgxMDAlKQ0KPiDCoHJlbmFtZSBk
cml2ZXJzL2NyeXB0by97ID0+IGludGVsfS9rZWVtYmF5L01ha2VmaWxlICgxMDAlKQ0KPiDCoHJl
bmFtZSBkcml2ZXJzL2NyeXB0by97ID0+IGludGVsfS9rZWVtYmF5L2tlZW1iYXktb2NzLWFlcy1j
b3JlLmMNCj4gKDEwMCUpDQo+IMKgcmVuYW1lIGRyaXZlcnMvY3J5cHRvL3sgPT4gaW50ZWx9L2tl
ZW1iYXkva2VlbWJheS1vY3MtZWNjLmMgKDEwMCUpDQo+IMKgcmVuYW1lIGRyaXZlcnMvY3J5cHRv
L3sgPT4gaW50ZWx9L2tlZW1iYXkva2VlbWJheS1vY3MtaGN1LWNvcmUuYw0KPiAoMTAwJSkNCj4g
wqByZW5hbWUgZHJpdmVycy9jcnlwdG8veyA9PiBpbnRlbH0va2VlbWJheS9vY3MtYWVzLmMgKDEw
MCUpDQo+IMKgcmVuYW1lIGRyaXZlcnMvY3J5cHRvL3sgPT4gaW50ZWx9L2tlZW1iYXkvb2NzLWFl
cy5oICgxMDAlKQ0KPiDCoHJlbmFtZSBkcml2ZXJzL2NyeXB0by97ID0+IGludGVsfS9rZWVtYmF5
L29jcy1oY3UuYyAoMTAwJSkNCj4gwqByZW5hbWUgZHJpdmVycy9jcnlwdG8veyA9PiBpbnRlbH0v
a2VlbWJheS9vY3MtaGN1LmggKDEwMCUpDQo+IA0KDQpHcm91cGluZyB0aGUgSW50ZWwgY3J5cHRv
IGRyaXZlcnMgdG9nZXRoZXIgbWFrZXMgc2Vuc2UgdG8gbWUuDQoNCkFja2VkLWJ5OiBEYW5pZWxl
IEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+DQoNCj4gZGlm
ZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMmRiOGI0OTQwZGU4
Li4wMDU0ZGMwZTVmMGIgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5U
QUlORVJTDQo+IEBAIC0xMDQyMiwxMSArMTA0MjIsMTEgQEAgSU5URUwgS0VFTSBCQVkgT0NTIEFF
Uy9TTTQgQ1JZUFRPIERSSVZFUg0KPiDCoE06wqDCoMKgwqDCoERhbmllbGUgQWxlc3NhbmRyZWxs
aSA8ZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNvbT4NCj4gwqBTOsKgwqDCoMKgwqBNYWlu
dGFpbmVkDQo+IMKgRjrCoMKgwqDCoMKgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2NyeXB0by9pbnRlbCxrZWVtYmF5LW9jcy0NCj4gYWVzLnlhbWwNCj4gLUY6wqDCoMKgwqDCoGRy
aXZlcnMvY3J5cHRvL2tlZW1iYXkvS2NvbmZpZw0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlw
dG8va2VlbWJheS9NYWtlZmlsZQ0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8va2VlbWJh
eS9rZWVtYmF5LW9jcy1hZXMtY29yZS5jDQo+IC1GOsKgwqDCoMKgwqBkcml2ZXJzL2NyeXB0by9r
ZWVtYmF5L29jcy1hZXMuYw0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8va2VlbWJheS9v
Y3MtYWVzLmgNCj4gK0Y6wqDCoMKgwqDCoGRyaXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkvS2Nv
bmZpZw0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9NYWtlZmls
ZQ0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9j
cy1hZXMtY29yZS5jDQo+ICtGOsKgwqDCoMKgwqBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5
L29jcy1hZXMuYw0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9v
Y3MtYWVzLmgNCj4gwqANCj4gwqBJTlRFTCBLRUVNIEJBWSBPQ1MgRUNDIENSWVBUTyBEUklWRVIN
Cj4gwqBNOsKgwqDCoMKgwqBEYW5pZWxlIEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRy
ZWxsaUBpbnRlbC5jb20+DQo+IEBAIC0xMDQzNCwyMCArMTA0MzQsMjAgQEAgTTrCoMKgwqDCoFBy
YWJoam90IEtodXJhbmENCj4gPHByYWJoam90LmtodXJhbmFAaW50ZWwuY29tPg0KPiDCoE06wqDC
oMKgwqDCoE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+DQo+IMKgUzrCoMKgwqDC
oMKgTWFpbnRhaW5lZA0KPiDCoEY6wqDCoMKgwqDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jcnlwdG8vaW50ZWwsa2VlbWJheS1vY3MtDQo+IGVjYy55YW1sDQo+IC1GOsKgwqDC
oMKgwqBkcml2ZXJzL2NyeXB0by9rZWVtYmF5L0tjb25maWcNCj4gLUY6wqDCoMKgwqDCoGRyaXZl
cnMvY3J5cHRvL2tlZW1iYXkvTWFrZWZpbGUNCj4gLUY6wqDCoMKgwqDCoGRyaXZlcnMvY3J5cHRv
L2tlZW1iYXkva2VlbWJheS1vY3MtZWNjLmMNCj4gK0Y6wqDCoMKgwqDCoGRyaXZlcnMvY3J5cHRv
L2ludGVsL2tlZW1iYXkvS2NvbmZpZw0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50
ZWwva2VlbWJheS9NYWtlZmlsZQ0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwv
a2VlbWJheS9rZWVtYmF5LW9jcy1lY2MuYw0KPiDCoA0KPiDCoElOVEVMIEtFRU0gQkFZIE9DUyBI
Q1UgQ1JZUFRPIERSSVZFUg0KPiDCoE06wqDCoMKgwqDCoERhbmllbGUgQWxlc3NhbmRyZWxsaSA8
ZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNvbT4NCj4gwqBNOsKgwqDCoMKgwqBEZWNsYW4g
TXVycGh5IDxkZWNsYW4ubXVycGh5QGludGVsLmNvbT4NCj4gwqBTOsKgwqDCoMKgwqBNYWludGFp
bmVkDQo+IMKgRjrCoMKgwqDCoMKgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ny
eXB0by9pbnRlbCxrZWVtYmF5LW9jcy0NCj4gaGN1LnlhbWwNCj4gLUY6wqDCoMKgwqDCoGRyaXZl
cnMvY3J5cHRvL2tlZW1iYXkvS2NvbmZpZw0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8v
a2VlbWJheS9NYWtlZmlsZQ0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8va2VlbWJheS9r
ZWVtYmF5LW9jcy1oY3UtY29yZS5jDQo+IC1GOsKgwqDCoMKgwqBkcml2ZXJzL2NyeXB0by9rZWVt
YmF5L29jcy1oY3UuYw0KPiAtRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8va2VlbWJheS9vY3Mt
aGN1LmgNCj4gK0Y6wqDCoMKgwqDCoGRyaXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkvS2NvbmZp
Zw0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9NYWtlZmlsZQ0K
PiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9jcy1o
Y3UtY29yZS5jDQo+ICtGOsKgwqDCoMKgwqBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L29j
cy1oY3UuYw0KPiArRjrCoMKgwqDCoMKgZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9vY3Mt
aGN1LmgNCj4gwqANCj4gwqBJTlRFTCBUSFVOREVSIEJBWSBFTU1DIFBIWSBEUklWRVINCj4gwqBN
OsKgwqDCoMKgwqBOYW5kaGluaSBTcmlrYW5kYW4gPG5hbmRoaW5pLnNyaWthbmRhbkBpbnRlbC5j
b20+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9LY29uZmlnIGIvZHJpdmVycy9jcnlw
dG8vS2NvbmZpZw0KPiBpbmRleCA1NjQ2NmVlYjRlZWYuLmU4ZDlmYzk1NDEyMSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jcnlwdG8vS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by9LY29u
ZmlnDQo+IEBAIC04MjEsNyArODIxLDYgQEAgY29uZmlnIENSWVBUT19ERVZfU0EyVUwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHVzZWQgZm9yIGNyeXB0byBvZmZsb2FkLsKgIFNlbGVjdCB0aGlzIGlm
IHlvdSB3YW50IHRvIHVzZQ0KPiBoYXJkd2FyZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgYWNjZWxl
cmF0aW9uIGZvciBjcnlwdG9ncmFwaGljIGFsZ29yaXRobXMgb24gdGhlc2UgZGV2aWNlcy4NCj4g
wqANCj4gLXNvdXJjZSAiZHJpdmVycy9jcnlwdG8va2VlbWJheS9LY29uZmlnIg0KPiDCoHNvdXJj
ZSAiZHJpdmVycy9jcnlwdG8vYXNwZWVkL0tjb25maWciDQo+IMKgDQo+IMKgZW5kaWYgIyBDUllQ
VE9fSFcNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL01ha2VmaWxlIGIvZHJpdmVycy9j
cnlwdG8vTWFrZWZpbGUNCj4gaW5kZXggMzRjMWU2MGQ5ZGQxLi5lYjhlYjgwYWFiM2IgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRv
L01ha2VmaWxlDQo+IEBAIC01MSw1ICs1MSw0IEBAIG9iai0kKENPTkZJR19DUllQVE9fREVWX0FS
VFBFQzYpICs9IGF4aXMvDQo+IMKgb2JqLXkgKz0geGlsaW54Lw0KPiDCoG9iai15ICs9IGhpc2ls
aWNvbi8NCj4gwqBvYmotJChDT05GSUdfQ1JZUFRPX0RFVl9BTUxPR0lDX0dYTCkgKz0gYW1sb2dp
Yy8NCj4gLW9iai15ICs9IGtlZW1iYXkvDQo+IMKgb2JqLXkgKz0gaW50ZWwvDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NyeXB0by9pbnRlbC9LY29uZmlnDQo+IGIvZHJpdmVycy9jcnlwdG8vaW50
ZWwvS2NvbmZpZw0KPiBpbmRleCA3YzlmNTFiODczZWEuLjZhOWFiZGYzODQyMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jcnlwdG8vaW50ZWwvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2NyeXB0
by9pbnRlbC9LY29uZmlnDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiDCoCMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gwqANCj4gwqBzb3VyY2UgImRyaXZlcnMvY3J5cHRvL2ludGVs
L2lhYS9LY29uZmlnIg0KPiArc291cmNlICJkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L0tj
b25maWciDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9pbnRlbC9NYWtlZmlsZQ0KPiBi
L2RyaXZlcnMvY3J5cHRvL2ludGVsL01ha2VmaWxlDQo+IGluZGV4IGIxMjYzZjFmOTBjYy4uMTU5
YTVmZDNlOWFjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9pbnRlbC9NYWtlZmlsZQ0K
PiArKysgYi9kcml2ZXJzL2NyeXB0by9pbnRlbC9NYWtlZmlsZQ0KPiBAQCAtMSwzICsxLDQgQEAN
Cj4gwqAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+IMKgDQo+IMKgb2JqLSQo
Q09ORklHX0NSWVBUT19ERVZfSUFBX0NSWVBUTykgKz0gaWFhLw0KPiArb2JqLXkgKz0ga2VlbWJh
eS8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2tlZW1iYXkvS2NvbmZpZw0KPiBiL2Ry
aXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkvS2NvbmZpZw0KPiBzaW1pbGFyaXR5IGluZGV4IDEw
MCUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9jcnlwdG8va2VlbWJheS9LY29uZmlnDQo+IHJlbmFt
ZSB0byBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L0tjb25maWcNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY3J5cHRvL2tlZW1iYXkvTWFrZWZpbGUNCj4gYi9kcml2ZXJzL2NyeXB0by9pbnRl
bC9rZWVtYmF5L01ha2VmaWxlDQo+IHNpbWlsYXJpdHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJv
bSBkcml2ZXJzL2NyeXB0by9rZWVtYmF5L01ha2VmaWxlDQo+IHJlbmFtZSB0byBkcml2ZXJzL2Ny
eXB0by9pbnRlbC9rZWVtYmF5L01ha2VmaWxlDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0
by9rZWVtYmF5L2tlZW1iYXktb2NzLWFlcy1jb3JlLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9pbnRl
bC9rZWVtYmF5L2tlZW1iYXktb2NzLWFlcy1jb3JlLmMNCj4gc2ltaWxhcml0eSBpbmRleCAxMDAl
DQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvY3J5cHRvL2tlZW1iYXkva2VlbWJheS1vY3MtYWVzLWNv
cmUuYw0KPiByZW5hbWUgdG8gZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9j
cy1hZXMtY29yZS5jDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9rZWVtYmF5L2tlZW1i
YXktb2NzLWVjYy5jDQo+IGIvZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9j
cy1lY2MuYw0KPiBzaW1pbGFyaXR5IGluZGV4IDEwMCUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9j
cnlwdG8va2VlbWJheS9rZWVtYmF5LW9jcy1lY2MuYw0KPiByZW5hbWUgdG8gZHJpdmVycy9jcnlw
dG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9jcy1lY2MuYw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jcnlwdG8va2VlbWJheS9rZWVtYmF5LW9jcy1oY3UtY29yZS5jDQo+IGIvZHJpdmVycy9jcnlw
dG8vaW50ZWwva2VlbWJheS9rZWVtYmF5LW9jcy1oY3UtY29yZS5jDQo+IHNpbWlsYXJpdHkgaW5k
ZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBkcml2ZXJzL2NyeXB0by9rZWVtYmF5L2tlZW1iYXktb2Nz
LWhjdS1jb3JlLmMNCj4gcmVuYW1lIHRvIGRyaXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkva2Vl
bWJheS1vY3MtaGN1LWNvcmUuYw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8va2VlbWJh
eS9vY3MtYWVzLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L29jcy1hZXMuYw0K
PiBzaW1pbGFyaXR5IGluZGV4IDEwMCUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9jcnlwdG8va2Vl
bWJheS9vY3MtYWVzLmMNCj4gcmVuYW1lIHRvIGRyaXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkv
b2NzLWFlcy5jDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9rZWVtYmF5L29jcy1hZXMu
aA0KPiBiL2RyaXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkvb2NzLWFlcy5oDQo+IHNpbWlsYXJp
dHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBkcml2ZXJzL2NyeXB0by9rZWVtYmF5L29jcy1h
ZXMuaA0KPiByZW5hbWUgdG8gZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9vY3MtYWVzLmgN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2tlZW1iYXkvb2NzLWhjdS5jDQo+IGIvZHJp
dmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9vY3MtaGN1LmMNCj4gc2ltaWxhcml0eSBpbmRleCAx
MDAlDQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvY3J5cHRvL2tlZW1iYXkvb2NzLWhjdS5jDQo+IHJl
bmFtZSB0byBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L29jcy1oY3UuYw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jcnlwdG8va2VlbWJheS9vY3MtaGN1LmgNCj4gYi9kcml2ZXJzL2NyeXB0
by9pbnRlbC9rZWVtYmF5L29jcy1oY3UuaA0KPiBzaW1pbGFyaXR5IGluZGV4IDEwMCUNCj4gcmVu
YW1lIGZyb20gZHJpdmVycy9jcnlwdG8va2VlbWJheS9vY3MtaGN1LmgNCj4gcmVuYW1lIHRvIGRy
aXZlcnMvY3J5cHRvL2ludGVsL2tlZW1iYXkvb2NzLWhjdS5oDQoNCg==
