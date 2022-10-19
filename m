Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A7604D6E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJSQac (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJSQab (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:30:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38551BE1F2;
        Wed, 19 Oct 2022 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666197030; x=1697733030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DoEFtUlHWgX9ZL6NYViX0WpC1XniQONXR55HfWD58yY=;
  b=NV57ihbBLrKatPe0thn/3bm8VXopqnhOvethMexbaQuZaRLRHbzLtUR7
   8bpdq8QsH64c8rMWStOHp337JBuvfjW1N2L7+xls1t4PQ6/A8aD7vuQLc
   Rt1eH0NiP137aPlNbmncrecesohMvPrie8dszl07C1dQfQutP2WqdMDzN
   W72tEK2Pr5XSaelpzafZfD/keY5y+Tkqy4DlkAnX9jEBUvSJfWazrSg82
   FgrU2F9Q7KKoZaUDx+q3tCqgio4YsOf+0XOC72q8fbAEQDZBahzE91hYp
   55fqYsK2kHDDxn0P7LMTN7qNd72AAy2FA8wjoWciAoDfWkBJFotXLIUzi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="368517028"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="368517028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 09:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="698158398"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="698158398"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2022 09:30:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 09:30:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 09:30:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 09:30:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 09:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcNFY4ichfkYrLPZlU9AFO6gpidSgGj6O08G7+97t66UVV+kqQ/XHLvOEAOlZ7jFNPiiCfumTZmfyI8jxTfPgJSR9vm4cPStB4LqOnQxVNuqjekGHoOtST2SvcNU4fTb9k9DDJzpel2BwNSyvFxo8QH+LbGwjaL8TUhEWXV3N+aYewAWpWmcITs9rnJF1IS2Tk8q+jg87c7GiuQZaeCsmu4gIBqaDvPC8G4yjLcnxc7+dfMD21Nh6WcjKxocwKg6wnSLywNao1g0IxJ1AsGA60l/gzKQL7UqNb0otNH25UEw0MPcMrXQB+MDfRJBZzaMsNeuEoclkcbL+0mq8/B4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aKejjnIldIxh+UEhHpGDZ3hicdfhSiygYButJe5EVA=;
 b=GOcE7KL0waUs5+FA/BD0d4equICTwgwR9c/LqMbdAqY9n68O1/iV9TqwlxbJuqkFGCDnXoJKdrmJkjvxTzCu36OfVNOAjuB5O25KkqI6upwA1SHI6QzVW0h+1Xl37dpdQqEoka8qgKxe2S2HOIYUTJRJNoEzTubV6gPAK2peAU8oZhLNJhmkn4M4gbofAqgbbyXM1W2Ue7aIPlYVXVK0DorKAPBYCSxxHN4Ty+RkZURMnQwWNaRx8lp+Ua3/k2OWeQFuiFvWj9C2BMOmqmkjwTtbaSJz98ljTNBb9qcxVGkeLuZMazTzqBL5j+0+RMXqK+Zl23Oh71grOLceP0XOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB4945.namprd11.prod.outlook.com
 (2603:10b6:303:9c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 16:30:27 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:30:27 +0000
Date:   Wed, 19 Oct 2022 09:30:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 10/17] dmaengine: remove iop-adma driver
Message-ID: <635026214360d_17cf29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-10-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-10-arnd@kernel.org>
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: e891f57c-c0e4-425e-d755-08dab1ef3b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P77llmSErCHVz2iTpin3PZ0fstS9Q10UK5D8dhN0QnzpkmzclYZhgCIFRk11R9T8qZ5O0/lI1le+gne8StgXyJGBrgqMEcGn/n7iqFiwFK2mXyHwbjyJxmaHzR58f0VoaqmP+/xCz6semiaNitSHXsVMzDiR0uKBGM/OVyla5Y09H5yBl6BTE+rRDDINqLD3uNpbzywLzDZFcJkAi4on0lmrWm5HahwtdgwhcqliFeKIKcocE4hTM9nY9l24MmGeyq6Mw+DzqB+mh2t2lIAIcbqwrMISI3j13IwZgAPhjnKdhUzI57zAo+TGj9hb3t73PNBujWP3pD/MhxxnMMd9WFwsGPoT0jhS2kxmwh6MeNgyLc03sZzbyjfxXMJ26v+cRDsyeODIQf51h5K5NLOuX4KHVEvQXOTr1LnkckNerCXPsZ86myKJClpB9kQ1OR/xbYvw/BYfqW9EISI7Uz+FJcF5JFZF9BIqTpydqiTf+R2OLwpLNNtPIFJPr6STSjmXkozh2GT9Hsl9fPsfbQvbAFVuGrAjMM7z4WI0ZH26V0X5aL/SXruRefKIGUrhcXiRTJ6rN0oNiPuLvFHHvmWOjzqMfXuT/Mph+IXDIwZ5ORIVPym1Wnjx9q9ZriUSeE37ha315QEEl1RC++EU18tdh2B3MnpaI7B36VWIcC5bL/S0QQR3q8YpXfhrPGt9f8GnmscTNWTyNGsyEXpBcsoT7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(82960400001)(38100700002)(86362001)(9686003)(6512007)(5660300002)(8936002)(41300700001)(6506007)(558084003)(66476007)(66946007)(66556008)(26005)(4326008)(8676002)(110136005)(2906002)(186003)(54906003)(316002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxkNYOszWT+fEelk0OyePjd9kZdeuSx9KNZ+3+fwq/k2URtW/MIuvSFKxMRC?=
 =?us-ascii?Q?CdtHzU7Fzvh0q/1cBYXVZAFebqBmhKrUzVovJfYqQHMRGD3UAklsiBsihuu5?=
 =?us-ascii?Q?j9qr8NCR64FfYvQmjeUsCvq1Eyi5RBiSJbK4arUNjgeLpMN5PuAyFhK0iNgP?=
 =?us-ascii?Q?wA4vDd9X5DqtojDD+57ORk4jGKehL8y9ERzH9av0kNQpD6slLp73Gi/oa9gc?=
 =?us-ascii?Q?vN9phcxaS2/ek3Ylq8Rx7qjVEPDPGeuvfHRDN0W/yikHnv5MSHLJiIv3Tfwb?=
 =?us-ascii?Q?PG1WwHBbqNhR1Ri6PVBHOzvN1qEgIdXyPcJbhayxn0l5WisKTDMRULWrGxxp?=
 =?us-ascii?Q?wIPHkjaELEP7eR8tVBvZUFSb+6nvOqdxOBtglPqi9WlGBEAHgTnryH5FJgv+?=
 =?us-ascii?Q?vuK6262+DUhWefFplWMdkCKPfirkM03Hr09DU8dEiIWCqw4mKnYliH/V2w5U?=
 =?us-ascii?Q?mNGiLX79CuRYLYo7D0O2UJYdmYDEeonKB6/8DqdNgFqyXJ58hKwsks1Wq9bY?=
 =?us-ascii?Q?vGIMDImvvA+Kr41LjbiDv0Mz8iUx3WDMKPatbk0GyurRwy9qUoEJMCwv83OP?=
 =?us-ascii?Q?Wl4t+ILABaSYH91uff42JudldioBFgFBhu31Ucg2TEFrcEe7gl7a7+6cr+e5?=
 =?us-ascii?Q?Jf8SpL1NsbXVX2PUbgf07U8I9RUu8doiZERdCwYYXd3vsYQdNGBZ07VbtiH1?=
 =?us-ascii?Q?JummYExAqcveBeVt8J6t8KbmZN1xOCiGEE6X4YNbIx8AvEjIZKl+0qDdIBEu?=
 =?us-ascii?Q?4r2mZZoBTyssaKYuJfPQaCDm1PjF2CIJqLjaawSdJORbiyi8ZE6loD7/epGB?=
 =?us-ascii?Q?bOGP4sdfSYoVMgzL7Q+aWo9frhD/3dScX68QbeFl9pNjwRGEFpOmhnnddeFY?=
 =?us-ascii?Q?6hvsyxjMt3SRvfCe9e3J7Gh3NIe0oyoTUkERgaCbVNLPxHHf+++I5ivI6E9+?=
 =?us-ascii?Q?NxIsakAgbqJegnu1A72ZDUJhDYYPacUyfhBep6ZcnlU3oSiL3mnlEx4GurLk?=
 =?us-ascii?Q?xS5S2vwPtVE1KnRtAloaB1ogFLinNfuep4H2pE/8mIQPvHKlv4pPmVNreEYo?=
 =?us-ascii?Q?URpYtTk+qZXhbnMz8JmbRcqzku7Y4eiaGDRV8jgb/0sgbqLtOWTl8LbMc/xW?=
 =?us-ascii?Q?oKINJdDr/mKqnAsDszuMb3EyJg+p/mYxQyQHgqu6YG7sku5ZZVNNH98oTPo9?=
 =?us-ascii?Q?uFVrQtlNKkHSs5fWcVq0E8uG78V1OmWwlMV9+jp64RCUqyOIiB/4SOHWtHPD?=
 =?us-ascii?Q?T+ZANgpYmom4Pd52HwBluo0Y2hZonRqRaM/DUbrTmlSqIsZa+aMl9I6Qyn5B?=
 =?us-ascii?Q?fJfmi/SdgAC+Qth2g44n4SjXx06mHGI+Vxu1HtBBuEE1t1darPs/fS15I+L+?=
 =?us-ascii?Q?EQfz6ChQaaK/ejK5024AzamRFv873VAKh4mUSH7IKSWFV0e3OrUQ+7e5v8cd?=
 =?us-ascii?Q?mDeGZEUy8RtfK8rBZiyvrDj4ZV/7osNwp0aPsLOxEpI/CstxpOdzC8mANwZm?=
 =?us-ascii?Q?yGPEDHw3hBj/jrpkUAN1JwViRIlJZixHNItN6jNoaXM7rVlcW9D8KIgTCT/n?=
 =?us-ascii?Q?BprMS/AJ8Ko+U8Ex9tFiZMYAgTwYwx6GvDa97mFJAJoL6IAZXdjv7yKhYZaH?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e891f57c-c0e4-425e-d755-08dab1ef3b0d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:30:27.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YtH77QSZxXtgrCbmLUb92bnDt8dmrSaBGrD3Xw/q2ObRUOHQcEfDBHMwxm34R+sawgV8BW5VDRSc6eGFLrgiG9FkhzEXmpQ54VJez65lms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The iop32x platform was removed, so this driver is no longer
> needed.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
