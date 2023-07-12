Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00010751442
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jul 2023 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjGLXOJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjGLXNv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 19:13:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C682268D;
        Wed, 12 Jul 2023 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203603; x=1720739603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2NaEeDR2OwIALDSSHu9LXHA2bmh356UsgChcigYQ8o=;
  b=AOYswIhpCEgMinRbrNAsaandKqzGFlNb+wPHpLCBmB1ObjympO4hEIFv
   xlIZcRJT5KZQ4EKR2W9PYcPmCPw1CdsZ2aXLYlXOWQTgAcqBApD4HU8Vl
   lY1W7BbPJ2V+EimbWHhcuFm+/WeAI8yTkOUkmVwEU9O2hKDIn0IHUH60Q
   nJMahOzZ9msOYXR7lL1DIZFf6ts2ktPsrd4LozCjRdc+g6It+y9HPWhUQ
   xyNQ7czy2dVj4HtDUgKLZkbsvQFKuErc3W+xo0wRDgOBRIfV7LETQ9RMW
   hwOipOgEVBAipVyL+0vzY9gKSBDmdYe4D9IRqBo0uJvIDlSHIFtAMYnck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367655433"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367655433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895772875"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="895772875"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2023 16:13:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 16:13:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 16:13:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 16:13:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 16:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpSlqnJuvIouPbBYwKO/FeSwsexF0HXlYN2O/qAm9yM5NBJWM7pRQA5X8rfoPuYFhxMFrlA2R02uN9apKQCX+92Y2vZtWpA54f20PddFIdTIuMFPlgC7LSbglfWW1btXFXI2AsGB1NFnFyvhsd+TQlQgALvSMuLHV3Cc7w7IR29int6RRkJb4AcwUm/EN+cbMwNeOQC30oPmILZPuDx6/DTCoqww/i+/ekAD53V1z3cjlWarQOkAs244N0fNSTffWE3ipKHawLS3SNVdM//Hu1ZCIfF73+czokHxcN0vtp6MFqKISeEZWktTvRGVgToSOBJ6xAfkcqLmqdJd3PCbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2NaEeDR2OwIALDSSHu9LXHA2bmh356UsgChcigYQ8o=;
 b=B6pV9dK7PdMzJTC/B5NcNdj/XX4vO6l7kbjSTFmtPjw4H/mCRYTRTxsnLZ9Nw8yzBjuOHA6dSrE3EN7rHz1dPluztJG2HTy02/NwKDRVD5nQs7JqcQp8Qh4lugZp8wLIvx3zGctB4aSvyD9S2aH0MksYOHwFixrNXkJSp5FeVXqc9WFc7KkZ7UKVM/9hfj2YakmpA6UOAHhS5CZpeIpWo8VCqkvLqbxrsmJONHZQ9aOFoMwEOj9KZs8JzgpCjelXD9Q/KtwQHc4+42l4iQctINpBAofFc7TWqzhCOoCCL5hCY0s+t2Z4oLWbHxjgmeaySmQnYxSSgjDOePQinAIxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 23:13:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 23:13:07 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
        "Guilford, James" <james.guilford@intel.com>,
        "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
        "Gopal, Vinodh" <vinodh.gopal@intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v7 02/14] dmaengine: idxd: add external module driver
 support for dsa_bus_type
Thread-Topic: [PATCH v7 02/14] dmaengine: idxd: add external module driver
 support for dsa_bus_type
Thread-Index: AQHZs2HAZYzmJNKunEibFlATGiXQ/K+2xeMg
Date:   Wed, 12 Jul 2023 23:13:07 +0000
Message-ID: <IA1PR11MB609789B3076DAB33C4A9039A9B36A@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
 <20230710190654.299639-3-tom.zanussi@linux.intel.com>
In-Reply-To: <20230710190654.299639-3-tom.zanussi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SA2PR11MB4955:EE_
x-ms-office365-filtering-correlation-id: 4fed3b69-e278-425d-9b69-08db832d8da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdcoeuds1RM4b2ifu74Ze5wES56WmIIoogQyfaUmCcQdkpPI5vw8UoXrn0U4c9N9XYGuB1xaxTj0wSoqLlI20F3V7o+Ir51lbDIKmZa0WT4rVXHQsLYkTnIt+gCxFJBw6LOhwu+t9kS+GvMJ2QiVUCwmEHz22pjb+RJwzWkO2+94zG93ZbwseQKEIV4nJZT0AZLKOZqU5twZU0lgBXpX3Ae1meXCHOIfA/iOpbQiflwpB0v6wou18b0FIRRNY+nZ2Jn3TENqiTDDTAOU3EXYQWvseqC2qxmc+SpGe7jS+pCOcd6cn/VOcjXLTCcVeT7Av4A7Kgs0xHTS1USQwOIyT5rEv7Etm6/VIoBx2wtCofDYqrbHiA1mtQoE2JbLryqSQo8/Zw4l7fBppO7LeGDJWc1fqLj72W3ZqUbKTqjRXG/3K/rrwc43xepUEAeU7FaXhOh4p3ZUzd+ZZFbMzhaCOKW398Mslkam/9CPv0Qm8nLtAOmXUYLUudFSJqQrntVg97v36CJwwl5E5CYlDe3AD4Y2+gfk52S0DAY0k6WcRnVqG0d0ary9RM5c0xhK8e6SMwJl14fFsOGru6NAD6EZDPMPqpCDo7n1sOXF7Je7p95g+Ksknp99xHMzhbqLDnGq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(71200400001)(7696005)(82960400001)(478600001)(110136005)(122000001)(54906003)(76116006)(558084003)(8676002)(52536014)(5660300002)(8936002)(2906002)(33656002)(86362001)(38070700005)(4326008)(316002)(66476007)(66946007)(55016003)(64756008)(66446008)(66556008)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FeeTnjBFfY0kdyKwe1j3NRd4vHCS5qDVy3tpe18NNnOxOW8CRMMJ7MxNos/S?=
 =?us-ascii?Q?DP/4XOAFS/NCDU1FtQaE180zGFRZefvmrlAKi13W71fuA5uWnsm+YEktUle3?=
 =?us-ascii?Q?5fDNXPlG+yBY9WbUKlWdFCGPKMS0JD8dkqobPvzv8CcfsHeQisN+nP+zYNqq?=
 =?us-ascii?Q?2oZJbtpZECLiD6M2pXFhmIpllNjO1LTfkukPZFk7wfyFm7gM3+uyGsT8bn2y?=
 =?us-ascii?Q?0iVKX9TjLKKnV1sduTAVu2m5QSJ+aScD05UUmpia1UYNrFLas3oAo5i/Uja3?=
 =?us-ascii?Q?Npl3IhaEuM6k+m7iOnYXVDBMgwFCjEHzyAeW3bb+S66+QQ2Cr6aO6mhcGDLi?=
 =?us-ascii?Q?+UOLZSAhLM0iUCP01kqSd0xBRQ2jwhzrruHl6YHKMzWtxJfTrUlLJO+qavdC?=
 =?us-ascii?Q?F6GNcvVywUexK5Ew+RBhyF5zkcO3rlSQGH9L5muKv3xTMlx4cCljJQLz2hsH?=
 =?us-ascii?Q?axHfgFKC6+L2ufedWS6TG60r7fwQLRAz9/B/Qe6KE5NxwBtCEUHnLQeorKOg?=
 =?us-ascii?Q?r2brYVpcD0UeQPxLj5gPUNAdwYfZHnDLrRyIGaB0ULjzjHokD2UimdZaOOy/?=
 =?us-ascii?Q?3gymbYP8GcEmgpmMDhjHdmWgCdcmO2+qD4O1gDDtZYH2+KnaUdozJk4ScAQS?=
 =?us-ascii?Q?I+cywVsczuAiqbCNC5qGMics7FkSciyn5v3bnDW9C3u/EK2WRSgLUzw0Bh6f?=
 =?us-ascii?Q?Ud2a1N3AWumBsjwqKIQJDTDsAkRE2psZjXY7V7rd9Vw/zdBnUyFS+hbNcvgn?=
 =?us-ascii?Q?AHKRv2fNUgrAQUEx2bALnvnD7WISxr6DcuxxLLQ6k0IGyCYFrje/cKSKK1Qp?=
 =?us-ascii?Q?LiQHjlAjlcsb+BmCdzpDQUJTkzGKR49Nosekz44HrQ2eWr7xh/nUr/eRu3vb?=
 =?us-ascii?Q?j1UDgrTWGGCXbCPqSQP9Xx9NQpr6L4RBgBnL2qbXtRn2j8iHjB+tEbDm7Qmx?=
 =?us-ascii?Q?GPzW0+QcYfrdWAuxAvlLxOzdq0QDuoUK2EDXNEoz64QHTY3ia2jMT50w+49w?=
 =?us-ascii?Q?dBaWRTBhR0GPvbEZOHE1uIUFdJZTMugPtyRNnRHBHIMqrxun+qv+8KcSfmH9?=
 =?us-ascii?Q?/sqzCU3H4jVuqJKqsE5El4MfCwZvlc6aWLmj5tQs5NqHG6BWif/0FWovTzI8?=
 =?us-ascii?Q?NEMTddtLA7oqA7VsV4DKBFnz8ydGf8WikcxMN+OySTpyyNRb7Ca1k/4RoUmk?=
 =?us-ascii?Q?hxGbaphe2BIQ5UHRoVuI6fRcgPIAYOkNPQP4RuvYA72cO/2gp5f6Y1GUeKnC?=
 =?us-ascii?Q?D3m3/WXIJpRncdC0MeLLGEB2K60TIGQ0j+lM4YeMZpZGtT3Cep/iXEGxZaS2?=
 =?us-ascii?Q?MojtAtzwI8Z/ZqlErTZYRMC2x5dASPC4418bLMKAw024qM944jgSE+MKZ+N6?=
 =?us-ascii?Q?wrEmXOmCzQ5s2ZiQH/nKQ6y3ZsfYprXLQvfg6lb38YTkkiBUUJQ9KZm/L1MP?=
 =?us-ascii?Q?wAxlyJgXod/5BBYtwAwVyJ/KvOEQvjilh4qB/amMeV3PL2h9HSwnqlj1OjwU?=
 =?us-ascii?Q?FF/uHs/5bE33C+Az2bpUYmxPZYb/F87o4y1rxRKpjw5KYc3QVuRtAPdLbpCU?=
 =?us-ascii?Q?hdQggc2sezgKnk0TjV6/EAKoY1tsKwHZsGBiECMu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed3b69-e278-425d-9b69-08db832d8da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 23:13:07.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYR3r+tN2kry+TEWl5h/alKnlXsmVKgFLw9S8ZIHRQ7LkwFrqFDO5q7vZGjr2QmieJNqwClzGX716Yti3vPP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> From: Dave Jiang <dave.jiang@intel.com>
>=20
> Add support to allow an external driver to be registered to the dsa_bus_t=
ype and
> also auto-loaded.
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
