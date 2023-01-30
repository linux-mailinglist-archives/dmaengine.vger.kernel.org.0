Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2586D6819FD
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 20:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjA3TLj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 14:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjA3TLh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 14:11:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25810F;
        Mon, 30 Jan 2023 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675105897; x=1706641897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YAGvMuO1Ug06y2pmJFnYHAhuqT/H7r14FaPK81yAUYk=;
  b=YeVzpNYAd8Y2Ol4dfkRelkSpAYdVMDQaMACVEDPVMyITxnR9qTRxVVr3
   xYgJTqtXj5TeSX2T4Is/3McrU2V6P300PYKDRAowkEgZhvZhSeg/Yk3hi
   IAvTpTnjQNmhnnyZl3HKUVmgp3YjIzaPPD/VgL1d4OgV5rhUbHw8QApK/
   niFm/1lZrufHxbbxU99ipbnrhUpjID2eXaXdLFpNY0FVrxJKlGM//e8kj
   6EY8FJFWHNhbigNUELoPLXNH187ddn6uEDxcX4zkagvZCHNo+ujf6TtFl
   srKNJO+Vswa7gEdb7Wo9pTnfUIzTYEfAoWzq3BJDjsAmvJVs3XyO9r5+T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325344325"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="325344325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="806802802"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="806802802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 11:11:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:11:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:11:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:11:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSARrHfHvwkJjDsc37T2h3Fnp0qOAr8Ghz9iR8UNE7Laz/8WeN/sFM/3J4vSghx7oZhdZ8Jpxzmh/UYZSH9A09A/nRqEBlm+fe2KmyshCU4CsqRequpLr1qh/jVMd+FYi2MAejIFeBZje6O15R5XYBH1aaoajpbHZFmibMsoBzPLSDiyxYGuKYfx15Zmwr9VPvdpKjPAdqVrdu6rLleK5ymgaSFi3VbzGiTqU4gVlGJ3a3kv/e071tXcsi/ewybQnXZ2RL3vrvCQzHOeBdwIjO3nTk/Rx3RMT8Uz/fcMufqLQKlMstzP5WnTXfsf2Yo7oyE2Iy25fP8gizcDeb+4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64dR28LlIRykv1DR2snIjyrz1ie70Jn29DNw2EHYMao=;
 b=N9PFfBCBKLM8+/6lEcAcIyJeXsKJk3W8ITGrKtQZL2n6qrRuhxtjLiXr+S6O97x+GqN5+6OhXo//24aS8Y1aURoPMqJ26g18iQlHqIpQcvilhlXf9g/B5243Vm6OuBzivYtmJFDwGNrVvNciQQrRuEyUxwR9xMA0bKHgo6bAAkgsXQ5sS0ASp6kGjUmpfq6hotGjEaCD+1VnzSMqeIxJ6pX/6zpVxUSYV/7/ZExlqi+NLOxVHSQEjy6OHvy+Swj8H1UHhDl739aakXt/S2bTNe9qqTW+ekd3eT5v47FOfqzDjN72T58q2uF5GZucAXRxsxs0toecQt/QThZ2EnBViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:11:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 19:11:31 +0000
Date:   Mon, 30 Jan 2023 11:11:28 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 2/9] Documentation: driver-api: correct spelling
Message-ID: <63d816603493d_3a36e52949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230129231053.20863-1-rdunlap@infradead.org>
 <20230129231053.20863-3-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230129231053.20863-3-rdunlap@infradead.org>
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 500bd372-5be1-40a5-2201-08db02f5cb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsqvnfS+tHvMGsoBKZGfzpUEs29BYzdXXiMFcoOHwRURAiLskF5NpjInmKpTqay3f9lE8JMABRhibkLug1yQ1MyFMw46w98OWUagMFnNInggQS3MSRaxX5616dYUxfkTqoglUmQF8h2frxWzaplN7YU+wXp0Y8K4m26slZ5HLaBizfR9J2xU//bDRBPLjn90ibHn9Cwb0BILmS6XLVRoJ6Op6162z3oAfQ+RYCkrk2yPoeh7BKh+rpksJ+WBLxMgX849iokBhLovdeSdDdGz8TPB+dXwZ3lTcgviNx9mzHuT94AVD2Myw231fzE9+xWOeSyyA4WzoqrYqCRGgCa2eCBNZSIlG8p+Ntt1L5bZ0fVvqwhKFKTEyiDK9oPW2APay+qIawWAYWrCcjxbhqGth6km+ugjUXywRXsT2GQoK6Bz8MCQXEXISDpKPv6ojbiOzgthuKbenaKZW+ULiFYZQbWAazLl9SQnwzqQUYqMupmCv2+9p2O7rCcz7gE9GMu2ouq6K+ANwb6IUEmwuA9NUa2jHjqClvdaktkEvdztK05qOthWbmH9O/11y67mbDbKDzeIkElg8lSXS5UIu4eahkKsJzMsdBjo6fPcGdPA0bnDr7CPrKJgCGrIiG8OfCVk0Fhe5FvoFYuqAur9cLGtAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(4326008)(41300700001)(66556008)(8936002)(8676002)(66476007)(6666004)(66946007)(316002)(54906003)(5660300002)(7416002)(6486002)(83380400001)(4744005)(26005)(2906002)(9686003)(186003)(478600001)(6512007)(6506007)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcN1vedortm2o8gN2nb7NRkjW5AfYj+yLeLVM04fPtJD1mOIi1j+/Jr1h1WQ?=
 =?us-ascii?Q?efomOHMrQllQiVfmMdk90Wvc7YPdBGZeIphPTWDSx5fUXDI2jg+r6zhgbXSV?=
 =?us-ascii?Q?vhMOv41F/TKmwI22XkfQsYVlkZmVUZSluO2mEO5Hv5zX7lKrt7VtmWaUg4Hs?=
 =?us-ascii?Q?lxnFTNbs25ldguNWzp002bvsH0OYPMtUzJRv4kZv6EF12SQ6G2rVE5c4+szH?=
 =?us-ascii?Q?RIA9/kugtWVQs/5rsH/RQM72Zkq141mVCh30NV62XCEKpH7VdMWk3T7SXuuH?=
 =?us-ascii?Q?JP2ZIPGbBYEXWwsB4b+Lg26b1tGRaiKe+755ZvyCRSz/OoWe2yRMg98jfVVD?=
 =?us-ascii?Q?DfwYAFB6/V7zJ+lOZ4dr9FGuAMG8cwK2N4NF38TXRUjK9H9gpn8jW/3FTC3P?=
 =?us-ascii?Q?++iHk2EmcnWs7IdHDK1KoajTTYhdI4dldjveo8RldhR+wI/UwgWiZEpFaUbR?=
 =?us-ascii?Q?IN+076aI9HnNsD7TRs7iYXyPhE8WpJm+nP9utmgRRlODuJaO5Cw1e0ZcBRVx?=
 =?us-ascii?Q?CM1tv6bjkMgF1nXrLH5RUbEQDG4pVMTAnW4hWmCHn8s/kU98pjRoN4hnmamv?=
 =?us-ascii?Q?z6cE9EJqqMdCmRLmOKrXL1ZLkFjLSUrhu/eiT4JIYFVYK042LsEwLfofITRS?=
 =?us-ascii?Q?8/c9xjSKE8BCQRCNuFqGJWrVmX1j8ziOT3Fxd0yInv+YdZjLLVsm5jYQCW+A?=
 =?us-ascii?Q?nBR+2uhBdYD4B8gdFwny/E0OpKSbxtOnbgAqyqHf65JBAB5eUzOki72TEtbW?=
 =?us-ascii?Q?J8Ia6iGsBIbzBRipsSJ2LmMkPcVfjDN7E6PY0xuRp3btrKVM80ZoAC7SuYNT?=
 =?us-ascii?Q?utVxjku2QzGnZP8BYxhH6m87B5bpyOURU0kgvpxHR8mw7U6XFvSKmBlsLNMM?=
 =?us-ascii?Q?MgtYNR7vHVYA8kDsdpyrrkPboSTZIw/WT7H3kclgBg69GbjAXqc5AOD/zf2y?=
 =?us-ascii?Q?0zR1sxaOu2fLyt2nHfhqQsDnw4osQUcPc8KkCp1x/eR6DbhFUjfitOXojpDH?=
 =?us-ascii?Q?b5ZKRxqCdF/7dK6z5hI+xMHbjDethvShoLVkphUsrby7a7nbvjnqto+VMymy?=
 =?us-ascii?Q?pHRdONzqufYiDkzTDVF3He+fqegy2KQ33h6KnLL4aoIeP+8rgUZn9+sJbhvQ?=
 =?us-ascii?Q?6X9IxC6+mZe0QAmOyBqxc3jGILf8NO7Wm2Kx56w7O2gtbMfDdcKKh3qAFdHv?=
 =?us-ascii?Q?dp8N5p+FRrJWy072rC9QhbeT6MkM+cIuCboSeSE8f4NZz7H15UINEQFsPW0t?=
 =?us-ascii?Q?VOqtU/hVQXcJ5cQ0J7B08k8x/a5yqabTcJ822THiUdu6EjP+AOiQ5dkQxclE?=
 =?us-ascii?Q?N5rI+IvwWaX5pnIrjvD3/YcMwlP7z6Ivukr5nbwxpvMBYrj/HSpyuMVCl2eV?=
 =?us-ascii?Q?75YKVKsxfgu48SmjebolZQKr0fsnySZFDvlB+2AIxpfFqrclFAIa5UiVXbrL?=
 =?us-ascii?Q?vTw3eUXBBhELyM74aRmbiMNodi1x6dqiURg00BTENoW/w9T0dZbAK4OnZ6UO?=
 =?us-ascii?Q?1K5fo0vmI7d+KY9tE3eNQLAjUf94+IzvPlJDozHkFFktkj2zJhf+guZMLpPs?=
 =?us-ascii?Q?10MfITM8CM9N16eJlQhLq3WYwkeDaoroc3IBrf6NFKhwWGvxkP/fr28BEmzB?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 500bd372-5be1-40a5-2201-08db02f5cb7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:11:30.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCnt9WFjy2VGtG/CMjkdz5UqdG1+z8MLMBlVfTo2FQMN8Q+/NOBqVbYLPgosTB2fivLbILq3B1B3gm60GgYyVnPFER1JcW8TLLPoVKljBk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Randy Dunlap wrote:
> Correct spelling problems for Documentation/driver-api/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: nvdimm@lists.linux.dev
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
>  Documentation/driver-api/nvdimm/nvdimm.rst            |    2 +-
>  Documentation/driver-api/nvdimm/security.rst          |    2 +-

For the nvdimm bits,

Acked-by: Dan Williams <dan.j.williams@intel.com>
