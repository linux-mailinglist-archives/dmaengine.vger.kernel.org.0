Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9235A0753
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 04:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiHYCjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 22:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiHYCjG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 22:39:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DD7FE74;
        Wed, 24 Aug 2022 19:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661395145; x=1692931145;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XKTEs05NTGIX+QFpHMNprOdoZG623IdQyhGmZ5dtfzE=;
  b=Snq8dcbat3m0ZPeJlyTsU4usI1dtDHbrKUyy4tyViQF9Hdm28RSq7Dlh
   WqWVzRcgCwo1ZZ1VLAIlnxZXKwIumQVddBbsYxjgJ6eLU4wqd208DP8hB
   YEbzLUpnu6ZKovziyVQ1C8kqgsIMvHJUr8gscu1RSR8S5v8kEjk3nwxW6
   vIUnxYClPlfvhqRGEshxJsCmSntafsepxo3tuT6XO/c3WCJD3mKLVWf3n
   cJ7MapzrTCK3dI3pxYvioVmxZjQstyryxkhoVvbXrK75JUHk888a6FOsC
   fGhp5HmDj+mJKrVXcdq/N6XMGcUynrpXUZaXdrf1gd/LKWq5JIVfGTmST
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291696641"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291696641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="713302989"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2022 19:39:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:04 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 19:39:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEw4AfLKFw6tzPduvh+6p6CJbBDn0MxGsdSKk7lOzYMX2sIxcxTAZZBgnFAug2sXzQFLdtQeOEw64W4ARBgofUZTyFyoXICrdHKlCzAaastJfurwTMHa3OYySCAJLruxmsGwi8pADuwq2YOLYaKHyOvQ7owx4Q2sbUExIIPbMfn6HoD48ePjYxQB+LDn1I2VnHcPdcF8Kmpdr07SzkMzV5yKla2CNsv51s6j8P11xY0WvvWd/eNTBdJlngZooBTfY6mBXbpQA2ij8FNXAyjJzr9VgJMFH2kiGCyTg3ENcQ/drrM6xjv4q6x4VuEUaHqmC9lv5m1xJNS+rL4JDiZXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKTEs05NTGIX+QFpHMNprOdoZG623IdQyhGmZ5dtfzE=;
 b=HNom9KO/ZGVwRalMAplwkLuBYLXq7dfOg4LRAhpc+zfahOE6lUgaF5frDmp61XDr/1Q79iwnfYaUy6SJHpvDsKSLuGKNiYnAG1tsgGebo/Dnw7FSt7N6QTMoF/escN3NY+bHEJXEBK/fJhiQLqXCKVeFVnBXirsgoP53IpRlOcFBsVB5aobysJWpCIn1xwXSgSbHvCQRTC6AHxvvvRUUXUw/O1BpqupGkr4syQZNme4O/eLaM5XKsu3kaTiIHmGyD5BdBjleUtf5hK5blpaihWcUA0TtGr4k+i4dwpMX480v/AJjQZDZPHIliIp39MAc45YzBpX4HIclUZlpq7L02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3674.namprd11.prod.outlook.com (2603:10b6:5:13d::11)
 by DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:39:02 +0000
Received: from DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42]) by DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42%4]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 02:39:02 +0000
From:   "Zhang, Li4" <li4.zhang@intel.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Zhang, Li4" <li4.zhang@intel.com>
Subject: Recall: [PATCH v3 2/2] dmaengine: idxd: Add additional IAA (IAX)
 definitions
Thread-Topic: [PATCH v3 2/2] dmaengine: idxd: Add additional IAA (IAX)
 definitions
Thread-Index: AQHYuCvWHjggTIdMfUmFXhe3x9EP3g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Thu, 25 Aug 2022 02:39:02 +0000
Message-ID: <DM6PR11MB36747C8E5E4B5F312AA48874AA729@DM6PR11MB3674.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32142d17-c5a8-4a31-6f34-08da8642f89d
x-ms-traffictypediagnostic: DM4PR11MB5488:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkGaUDs/wlzs8xZbByeH/NJ0r+z6aHYf5i6rG085QkPTnKPzB980SJfn/xe/XyRzPQ/y50I3/CtZ6o7JNlyaKSHojgdREYFB/f2IfApnLieZh9FVcbYGHN9jzkUlnEF+7prImclSV2C8ZRB8AHs+LnUXrk9sdSOWwIgIihWDHVqWL5JjGY5d5JC7z6WmhVGdPavSddu+6zw79qAgvQWo1Ty/e+12DHpkoyh02K85oyjaUsRvahlufQWvoRBr43yyYrtUblQaVGUvT2FLWBYPrNrgC1Z9xDK2mjbfFzDtMDvmq8X3t0EsIzQkx5ZYo0a7pYjBidB6ykDKBzP/SRfxc7CsysNCm7YUcNOr3K5V6JKzhFTlCM/LZabUq5egtHEep7NU8iqV3rteLm1a+99J5yLbRkUdNs92L5crJRIcTJmenddsrvqwvlQ5BGet0k0a+hqCUjzEWVlba/RL/lNBC7YYaye/sN2qtFSahJR9nnRlIR1a2crG4e9JtgwuYzOEwZDm8D8djxsAkbJVt20ycmbXk3PhEGxezJ953OPxSKyO7wnmT2oTpzK9KZSHFrpCkMSJLx3b/n6ESHs3WETB7CMhB/lryxxwvKVUwSc6DnkJR7zjYUmYan/gXoxO//iPX1EC3zFGV3Ttq6FvNo5JztUV29hslnCBciJObSsx2H8iXBSMqHBv097GsvRCjK65ake5GJygdJskvyyw6V9JzJyAgY2cK8BmR5mNcwX+4DgmVRYgF+Q4+ah+Ao2VpsjkIm4flq3rtgQJQ48buDcx4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(376002)(366004)(83380400001)(186003)(66556008)(66446008)(66476007)(66946007)(64756008)(316002)(8676002)(54906003)(38070700005)(76116006)(71200400001)(110136005)(4326008)(26005)(9686003)(107886003)(41300700001)(5660300002)(558084003)(52536014)(8936002)(33656002)(478600001)(82960400001)(122000001)(55016003)(7696005)(6506007)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+DiNomrx64VOp42frJzSzpHHPpvPLKSMc45pxfNbzMFDbjRbr/pdrM2eUB1?=
 =?us-ascii?Q?eIZF3ZED3tlxRQWPTiVMTNKxrauq0GoQHADfOL9LPwVDFlK6EJXivNChNO8N?=
 =?us-ascii?Q?BttLNu55TPbbUWIf5gPoRhseo8Qk1nmCGHV8EVMQ4HDqXHP91FQEQpNVfmV5?=
 =?us-ascii?Q?2/bXD98BweSNYLQTcXovQIjqgUO1uwEDrttjKyuaqgW+L9iK+AZm38QkthkM?=
 =?us-ascii?Q?oIxAQ/HMSg2vBofUrPXcJdeURoUUkn6du8EMCKMUn2fb59c7hjP4K6zF6R+9?=
 =?us-ascii?Q?0FR7LqMKA2IP/pBIz17GiduM5FcK2IgQruX02EwSbA6HXfCj88fEAIQmlaaA?=
 =?us-ascii?Q?AIBn434yS6Qz3LZUZ4VS6SaNRpfuq9Xy6qFnTl8aLiNZ2Cg0hekU3W4xwvVk?=
 =?us-ascii?Q?okP9t2bSCQVuzB0LvBXOcaBK11JOWMHqvZgrqiuO1OHns9DAVVaplE5jDaMb?=
 =?us-ascii?Q?XY8w8KkjYdIGJ13webQp0VBhIJpmfdMIyU3wiZg9tIM6UlhFNoQ/2IIldWyt?=
 =?us-ascii?Q?U7Sp3KldALG+S1Mt10C1RyMro4CSxVapAgJLkyjLTjrRdSsIu5+XNqRR8rt7?=
 =?us-ascii?Q?er/54k+m3C1opdkV80rOP8R70PiXZE+RL8LoIKcGPJG5GvOLvtKRgRHMiz73?=
 =?us-ascii?Q?EvGbofd8xlcsoKhYVAVSe5UgwesHkWUm34QqotNORqoMRwK6NNT7o8Zsl77/?=
 =?us-ascii?Q?QoHuHnkaBGj97OQDwmP6b8TM4ZQcGyp0q27Q192a437OTh1SZTumBiFOUZ1I?=
 =?us-ascii?Q?Ecko7agIoTRAG97DEayTJh/1Quhz9sJz4DfU1CGtuo31BUdPyMu2MlvN23wT?=
 =?us-ascii?Q?q+vTMMOjNQcr79XpYatW4RrcAzCqbAd+dfIJt1U02Pcc5/7tItE65amBnmSZ?=
 =?us-ascii?Q?G+2Tb/CAoWwM83ruh1CYC8wSxoWfqRZQfmPjX7F8UscTpkejccSyTh/3elFP?=
 =?us-ascii?Q?udD+M24/ULC+kqJSmV29s3zWvg9Nx4eAE9/yrBMv5y+jZWAcrNKxvgvJF7NW?=
 =?us-ascii?Q?bBe6HmilJOgRONgJVMxqG4SCjws6T11lq/wJW1TaOkjuUHbpdZm87I+y0cCE?=
 =?us-ascii?Q?m+KDpkISnWl+AwbZfy9V9dhKGVY0j0Wf8Qm78o06BM1b+TPO9d/e0ZJzg1Qf?=
 =?us-ascii?Q?H/e/7l72ElBmwYjIGc7XzEev2dOWQ6bg8jsvkyiQU6Rcu4uXqa1+GqjP6ozB?=
 =?us-ascii?Q?r0s1nmDy7zKavuV9SHD88jS1/6ZE88j3kVpFLv0X0YS7Xs0OGoDgODJUA7iH?=
 =?us-ascii?Q?7LTylef4WHGrf/mHsT4paSMfsjUb63+LlI99cnx0lZuRADtQFpONQnUdZ1/A?=
 =?us-ascii?Q?8ZuqBUSt1iAzotfUs9o1BZpEGZofGRv8Lyj6SPaUsbL9G8lQKdgP2HBMCF81?=
 =?us-ascii?Q?0HV6DQoCo8z+pf2N8DEHMtpj+JJGUkPVfcHTA1IqBz/EfkLME5/peqncKn8j?=
 =?us-ascii?Q?ULecHpogrUTGmbwJ0/sflnFiRaEODP5EHtS6qMEwMN1N0zTPndp9+VxKcTNI?=
 =?us-ascii?Q?qHymur0k+8o1KuPSHvZ92qhuW+hrZ2rI7qvYl9Vm9VTxv1k3CpjaTmL2Hx9w?=
 =?us-ascii?Q?qBGPdAYRiowQZFE9IM/g8qeeF6AQrZMsL9JIr+eA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32142d17-c5a8-4a31-6f34-08da8642f89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 02:39:02.3064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDy29ADoK+bd541ztNQyewsFFXtAnxs0x11M7W7/vx+USD6zkL75BPc7635i2kYBc6Im51xQVAGmstOAqy8dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Zhang, Li4 would like to recall the message, "[PATCH v3 2/2] dmaengine: idx=
d: Add additional IAA (IAX) definitions".=
