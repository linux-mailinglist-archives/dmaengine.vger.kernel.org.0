Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50D5EFBDC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiI2RW5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiI2RWP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:22:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5751F1E9A
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664472082; x=1696008082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mbn2uY3E1Vq8U4QtU8kolBx6xpSda1rXF7oAi7uc9WI=;
  b=eQLYTKegtUbych10eefyVYIJgCvr09ILLIMr6rLY+nqP7LJInxnTxYjy
   rZyaKr3yznFnD94ty4cjYimwX6xPYY/WnUCEI1aHF3lIk5XU4bCoXscIr
   V+W24HZBa5uEK/ZJXyoP2OreOf8cObEiR6mgMwQmPcEF4rvWZphZAVQZh
   HO30SebWhYjk/Hcagorsgpo7CLcjb0BAgtMbOZHLEKX1nmosruXXJRRgT
   COjvQAT0mOJ5OZ+qXjOVtx2S3dWdiG5u6qzWIm9ND2QoGgpRiFpYt0YEQ
   Hkpiyse7kCPyzE5Ic1EGv1trSqtuiP7q/YoFV2sEEXOudYMApyqCtlKJd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302885652"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="302885652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 10:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="797648030"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="797648030"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2022 10:21:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 10:21:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 10:21:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 10:21:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 10:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foFiFKcd9ZYlllfFhyg7rVZG5BoFKWvmaK093GozjQ5VPFn3YTVy9howuwPRBFnpJgCIVc5Me9cklcPTAWd0wRZdt6P3JBcGZhNs6olwS9Uq2PDi3sckqCWo9V2L8HGcDrGwJkcsK2QCqHUwa2gvPksH9hZpRcIhhvHxfrJSt/gvNu3sefYTnRqS+lD/UZ0U8Q3qQ/3dRLOOhhWNC+C90kvrG5Opek9q8GpLX2gmRD0L8MO5aCHZayt7O/H01Cox+qP7eQQwis03t3+qlfPb/YoulYCJgoZXW+AEe9mdiw61uqnW3InIWsgiLLCEF8ZYgeLhPqGYcFrx/Z3X64cOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbn2uY3E1Vq8U4QtU8kolBx6xpSda1rXF7oAi7uc9WI=;
 b=Wv5SZm1/YAlWVPTV55+ZI+kO6BFjW8xepUAuKua4BqucPd7szNDwkuDGEwq/xZm5DjDPj5A6AYKpnG6PksfgNfXQOye/NazX9DhdIVgg45kpE4mIu8qGDjaxWcBv4ASXr+nCfZBHGGpLCDAG9Oej7i4S51ZXRQ8khV4EmyHUc2XJxafHc6YsYaqhHvwQrRMX+FlhbJguvaXNTrjFZtt7BT7R7g+8CsUMxii7/cuu910RgQKep2j+CXGdWg8v+dPjmwcMXql+jVARxfJvsp3Rd1Wja/43xNfaCyU6FgRcW2ue1HFb0HfEnv1qQfOvtpi2H78/lFFYii++loj+vLSHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 17:20:59 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%8]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 17:20:59 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: RE: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Thread-Topic: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Thread-Index: AQHYqs5k+3kjkZtlZkS8rDW1hVbuYK3g6C7ggBYIWwCAAAC5UA==
Date:   Thu, 29 Sep 2022 17:20:59 +0000
Message-ID: <IA1PR11MB60975AF68BA997D963F9EDB19B579@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
 <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
 <YzXL/HkYS2Q8QEbK@matsya>
In-Reply-To: <YzXL/HkYS2Q8QEbK@matsya>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CY8PR11MB7012:EE_
x-ms-office365-filtering-correlation-id: e5d7ee73-abad-4cb4-9847-08daa23efa40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwyiOHO8okMv0F7IguLqHeYrh4QOQX+MEa+AYpS4cdducpBv8IMfEoJ1oRg5c7kL8hHy4u6APTCQOgHSQq0I4UmQ3y5NT4/x8u61INPpI/C6S8LjL4hNVLoIRF7/C/bDvI3SG7fj4/+HSuSDV5UXe43jf0RmGcf4VToklybbW4eBk4Soy4c0MC2K8iA6uGLbN9nSokLD8+EJa9cK5pWeI3hvtWw/lIEVi2vKjlIhadHEwzzB7SlObEOqXbtqEBlXHoKXRaQD++RK4dnFmT/moxjKoOXchd2R9fRUWHaRzzfT9xtf0A8U/Z+j73evMIUJXsf3eIesznZ37VUVHimgTB2oO5URrarcK7AnKTWn5Azzv572JNYJWn9VE9il0B+rVmBJfkaCoxX93uCQVdx3FCy9QKQwErYmKRfWbWa9uxZSTbIeQ5W8duU6bOq36NuW88Y9wkb/6ab+2hu/g7wqrzykasOVjrk7r97Vyzdyh8sfAHoVh2EnT7lVJqarigi2bwQnFtfrimS/v85W6MVr5Iq8M+SIyWtTySVP7F7GXXqIacg94iPmQw/KuG38YE6GQ5d0QsXMSha5M4SZqOgvLAJ9AhsN14UpaKnNC3DDQIBAUtvs2GapL/QLHahV8kTdv6bynkFbwXmTx/mmISW2G62iX9JL/DojUgLHX2aDaxXSXUqmeZST8mOHnjZtVRaBXFnc9J9d2igc7EwB8RjUfEFTL+kzZQWElN9oQb1xHJZ6JsZl92aVcZWTBlNDr6gexxKGbfgsovnaeuu18kDVEeAu2yZ185zDu/POll7JOjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(66476007)(26005)(9686003)(186003)(478600001)(54906003)(7696005)(6506007)(33656002)(38100700002)(82960400001)(38070700005)(316002)(966005)(53546011)(71200400001)(107886003)(66446008)(2906002)(6916009)(8936002)(4744005)(122000001)(5660300002)(52536014)(66556008)(4326008)(8676002)(66946007)(76116006)(64756008)(41300700001)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RaFuhWji83rGBcyjEf41zXV31Uq2tKSGnMiBLPeHC3vhih1yeIbZJCEOPnJ?=
 =?us-ascii?Q?9Lz0OjrFbwGnonT3NFPSsKzH/ORX63Lj+UtNY9y7QH6F5ANPeWD2Szq0DG5L?=
 =?us-ascii?Q?VkHh3QEcXnORz5FoxfF7kmPWqgWenAfH3aIEjDE3enQGHYv7cGnlaz/fhdqF?=
 =?us-ascii?Q?DV1LYByKYE8LUUaUOBsyVkrhm/etkFMN3TesP1mIAJGZaI6wz0G7jwydALqG?=
 =?us-ascii?Q?s3fzfS+BeoUuPxBsO1TfHWeTVktzNYKIscI5RSbMiDLgSXvr4yk68SSeVsVx?=
 =?us-ascii?Q?2Mq8kAdhERy8jdKESIbvrry8KmeWB0Dk3o5wt1Ai+hgDX1VBgYnxcYOwtUBV?=
 =?us-ascii?Q?fQXR+JxXxEODQqm6QsJBDb8dWJsk/G5dbsjK7Ie5XtSnc/zjF5jpZB5um8Nd?=
 =?us-ascii?Q?Tg3LbKap/YBHfH2LgUF913H3ZT2mqVtFcDE4CHYuFY/wLBuMv3dgGS4mcs40?=
 =?us-ascii?Q?/+ykVNL0eUbW9ZOkPV44EzP/i73oLxNAVnZ1daC7GWqM/7fq8tSw9bfF7rzs?=
 =?us-ascii?Q?nr8JhNAZDb/tXwAYkNf1FGIyBe/xC3MzEZYUaQpkP/j2Yb3JUe7ACtqR7PTc?=
 =?us-ascii?Q?TqzpwAWA00v5gV14a0QvAcrcGOXgeTIVIveQYM6CNM3A28fd/sw2GxZTYGew?=
 =?us-ascii?Q?kzxcAGx4vAH+lcSP7IOQYFZTEwplWQTWJB2kDUUrg5QQEiRb7TMbfnajyAA8?=
 =?us-ascii?Q?VDYfcIUl4QLHbBLFjNnS/6lL6z7c6TUaGXPf/ao3k+axK5NVK8AXTVjI0ieE?=
 =?us-ascii?Q?nHoY1rTn/2jvYPmV9Tg1WbxwlRa7tLFhwGiXS1CKsI/2DczSTQZAsXOnGIzK?=
 =?us-ascii?Q?MbG+3khzuCdAQaHhptSzQjNM5o2Y2XOd1OjgvuRwgxrruVFe6zwdYArw7XzF?=
 =?us-ascii?Q?y5sSIW0w5WbMSwgz6n1Q5XUzHZEgqNqIfAHk4rJpt6k4pJzitTNjFZNbPxbU?=
 =?us-ascii?Q?flhk/w3+1xvzInJ2k2HZVfg9UkV2n88EsQPMqwBBAF8pxNCYzJtqaqFTDofh?=
 =?us-ascii?Q?8zhSGa6K/ZdUy5VS3utiAZqteRfEqpichsrP4pa4PRTcYthvogyZTfuV9Ylg?=
 =?us-ascii?Q?AHAhk6MAlaDLYunYnq69WC9j/zRLSz6ism8OyjVSPVaH7hmfXM5OGu7Rn4LU?=
 =?us-ascii?Q?TNnL3Ijp1BsdI6EJLiaaAGYdqWgU5mrdOi6QtmIiL2BtQGtuDGflaPFTbjmN?=
 =?us-ascii?Q?wxJ93Y/+o6d+9VzoOoGZqOssSbfvHeAw8+6LRwpXQflE6XTJfTorrxR5Kt6Z?=
 =?us-ascii?Q?s6Z6atW9WdeAT6MfcD6SD1lQAsdMYQUJWbxm1f/To0GiwpCgJhH7+pCBuqMu?=
 =?us-ascii?Q?Bd3dUHXloOfQTads9uhlo7/T0KAf4QV0/82rPuYBndZERYfRkyVdkIO2Jz6D?=
 =?us-ascii?Q?Xt0zQpPyoe+68nPr+0cX/tn5WQlGdYuYcYu5fjt7VuPJS/0bybzT/J3zqJWM?=
 =?us-ascii?Q?UzlYLu2joZrgm3hOApFhaHVHyZDePWdb6tpBzxTOhNRsuhDKKlVmZoFqqHv9?=
 =?us-ascii?Q?CwLnyFEsHCWmfi+39MxdOMGn9MEHBqVK0KQ6SkID3dFTPOEIG2Gyys7m9FzP?=
 =?us-ascii?Q?B0iTdWDERtyTuMZJSaU44pTF3OdT79ARmnLQqcKT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d7ee73-abad-4cb4-9847-08daa23efa40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 17:20:59.6243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2SbyvSKelAujQLYIh52hZx86oLNnD1v/rJubrr3vez+9Kc3xSyNUev7r9+USn8oulIsGpyvqrgXzEcm1oPUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

On 29-09-22, 9:47, Vinod Koul wrote:
> On 15-09-22, 16:21, Yu, Fenghua wrote:
> > Hi, Vinod,
> >
> > > Fix max batch size related issues for Intel IAA:
> > > 1. Fix max batch size default values.
> > > 2. Make max batch size attributes in sysfs invisible.
> >
> > Any comment on this patch set? Would you apply it?
>=20
> This does not apply for me (i guess due to other idxd patches I have appl=
ied
> today), pls rebase on next and resend

Is this the repo we need to rebase the patch set to? Which branch should be=
 used?
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git

Thanks.

-Fenghua

