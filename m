Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B6E640EAA
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 20:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiLBTpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 14:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLBTpW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 14:45:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4080E03E;
        Fri,  2 Dec 2022 11:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670010320; x=1701546320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4AmXsnGBH/zcsnYd8ra0j7DxA5+59du6nHOuIsZG+20=;
  b=XbVQQm1Xd1AphYkF9wjn71eXkLxYljZqakNgyB3kbY6XH3NPuUuqnISh
   MSsYoEk0sSECCpCW3cIZn+A1yhjKkOp+Eln3USaak/LqWGI/+UMomMc6m
   bVuV3MQbwnOZeY3GyyeLCpYoMPpxKquRXdHEqTW2xuvCPsIAEMB9UpBr5
   VNVdu1SQUBYS9IDMJwnBOxKKkeJH0Da5FSzTAVukI0uiVGxEWHXm55wqa
   BdHhxvBnLUWPgIl/silO2+aLTe1dQHJgf/Oyz1XvFGGbXcd2SFjocr3wx
   KYcqxmR6JMHjNIyZ851ZqXtALtcwFYLU85wOrSiBWNySuVIoUmBq+uJpt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380321970"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380321970"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 11:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787403985"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787403985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2022 11:45:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:45:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 11:45:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 11:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRAlkCkVBiftZFiSucFzgFzNHsX2GNXtsDzIXN6dxhq+JTMFVexr9kUPloKNMejbzWUutr3cBVJZ6ABbYf+bnHXPM4y48efJGJ3+RrVMpDwlc8lpGXWq/XQVlYiDZ2patlLVIYkD73/iSrT9r6H15GaqbjSpkCUC+aU07Ovt13c7zcKtbhUhGwwfdKICgmEEfbzW6ME0pP4iGuE0FYRBR5h9nCmMjFBUwKqKCl9Jp8iA51izP5XvAV9ftP4pilw88K/rMhiuPY7nciobeEi0Ynwgy5EwtaaJtEEh9ebuiw1mzvjTaxquhh2+MX7rUltefHq/1hcV43IJ9CzsghZbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfu9BUq2Klz8Fzx2ys84Xz0D15R/INVtNhD66TAgMm8=;
 b=mZAiOzHUg2tQP+MlXKM5eyVLViqGK3m7Kjxjv7f/de3Gzq7kwfzKOJcKV3Wbw0vF1iJZkHi88jV7qejLL3n448RvwBwpVlefZY6qILRpLYn8r2O9ju9vPM+SHnrALPL907jnZQGaHhXAitIvK7xAchd/R9dXqSTGVSggCImgJXa6dlbU8nXoarh8gOEpIFqI7/ir2XsT5JrtxVsA+/9QyBa/XQyNJ49zL+Gw+993Z6QH8bXXUgotajXVz+jOcMOJlsnVVA8Mb1TzNHckqbaJvDzvU5LnLHrMIq45tcBEwR7UsGYzzsY//3U9YWKVR+BlQLHbt5RTiuO6M0p6SUuB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 19:45:16 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 19:45:14 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: idxd: Prevent use after free on completion
 memory
Thread-Topic: [PATCH 2/3] dmaengine: idxd: Prevent use after free on
 completion memory
Thread-Index: AQHZBntzxBtxN/azOUOXL9lNk2N93q5a//JA
Date:   Fri, 2 Dec 2022 19:45:14 +0000
Message-ID: <IA1PR11MB60973AA139D6BE79958675ED9B179@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <96e5bcd4b97445227837c3a73e1a1abd93d26175.1670005163.git.reinette.chatre@intel.com>
In-Reply-To: <96e5bcd4b97445227837c3a73e1a1abd93d26175.1670005163.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB7889:EE_
x-ms-office365-filtering-correlation-id: 9f0a44ba-1dc2-4513-394e-08dad49dbb94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fq64LxMwhAv6RmYsGvAJK3AuBEKbnCsj5blYeorofxw2ChxA9jvR2NbacuhsGRQE9eQfgmBLSfF519lRPtKrfvvfqTNelhKUcxGJZltVFCzBMXLOTmGp21v+tbYsw2/QKCxMlAZ/HTmIrXVemhoaUB9XEYS6gadee6ihj5OL2cTOcEmhQiLdKhZW8vQPt/RSxQazTvmBi4PVQwjbDkIy94ivA3+YIKYRjvTFtFopP/tZse1tjCSO0JrAibcT7xOT1kkGQnGyXdpxwDbbHy1C3fDAP6SpJ9e5hZF8OYv6TAf2M8ulYLEqAwwII3ehnLRgLqT9yCNswrtt2rckv3NOPaLGUEzT9tfNvGyGEs0oebavfv2KQ54TqD6g+2VD23CscTeC809qcIvkNIYMQikTdA8N8rru9fs0ZJ+o6lE6QtmQps5O30vr4F4WE20nSlrhwEgZ0AuSCO8RaZXT9hyviRTuBcTRk1L+gCQJtfqeJFFvV4cZOobyz7vlhAPLH6G7yTy8sRRdZuEJfxBbIzjA/wv8CUGwx8n1tlU7FK28csuXTH9DvMFVI62gqrQbeAjdNQijKqHGvnG3SEsOdCmF1teMZ49zY8LHsBaixoOzNzi5u21YDCRoYOucfiOluVSJuYMRK1AnlpSzrntJ4yyLzmdDb37wDFaosaS3vIs8xG3keqdWf78A0P8yP9ONosuIIlaz+UVzAX7Rs6oB/VSmiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(26005)(9686003)(6506007)(71200400001)(7696005)(8676002)(4326008)(64756008)(478600001)(186003)(41300700001)(8936002)(52536014)(5660300002)(4744005)(83380400001)(76116006)(2906002)(66946007)(33656002)(55016003)(122000001)(38100700002)(82960400001)(110136005)(86362001)(316002)(66556008)(66476007)(66446008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ND5Qi2QGVuWtJz29rJDHSkP4KjfmkzTLSydBYfcRnnKmS+7EK+8LPibqDLtP?=
 =?us-ascii?Q?knk4Evb4BWQjTv8qasZSfHKYmplAmfnTfoDzlKskW35gtC+GSBs2M/WUOAg8?=
 =?us-ascii?Q?+dzlgGgWChMcPWkVeeyWb82xOS6yWtvWTpuXpMtgvxXUEVVcsg53LwwPEFIZ?=
 =?us-ascii?Q?UbVxnrOSM2is1ZMemf9kxm02h1cPokQNga4JdY5r2PsRkFzuNeb2bCg8NDdY?=
 =?us-ascii?Q?6Rh1v135jfAv+3ksw1V9LQzJ4wP26ir1HU6w3eu2ZyvvdzW0pTyCI3rPfdL2?=
 =?us-ascii?Q?9a6TYNE8yU56EboCHAaaewShdb4XL8w+1xQSvAFJcK1vkZpbuMHPRzWy6lxc?=
 =?us-ascii?Q?K/fBsANeioDmZbWfhQqk7M6qVyKkXuDz6vDi0tSmcmMP62pmpug8feuBQxwc?=
 =?us-ascii?Q?R3FsNU61/psYA06DYg/8TMN5IQ7aEOy6GiEwQ+vgfnAWs5aV+OEUUsAqPCRx?=
 =?us-ascii?Q?SlJ0+v5takZKu2/jA5l025XO/QSvngZZvHGGjG6GNOA0xw7yH/4yKK0lc3GC?=
 =?us-ascii?Q?GH/l6YXrQ2yaKh9+tShxLd1nlBNxsEllhU99fF4KjvjP7p5zuxOOHGkYzoMU?=
 =?us-ascii?Q?Ak1xLuoJvPFB34rD9WHv1Yx4KmiCkJI/jeBoM9QelgPcefk4swFH9cKwWv34?=
 =?us-ascii?Q?KQKMlzN0uBwJ6NEAFoUAs1u6gUE4I7oNQs1QXXhzFrzR5qlOsCyCkp6ClXkI?=
 =?us-ascii?Q?7frTHghR3cHYhrs4VYOk2iTs4Oe3fTnI/FCPewKIb1H7Hj9mD1tjm4vZojX6?=
 =?us-ascii?Q?wD5mP3+C9yElfYx6UEJJCVErUGE4zy0qhl99/RI4FJ/TioAHT/hsf71bnVYg?=
 =?us-ascii?Q?ICApHnqzrekk8yl1cBFuoh90+4SnSD91okjQc1fy8k0gfFWnXlrkpgVw8C3G?=
 =?us-ascii?Q?xXW2hudmLiGzUGno1xYiUMrFmZD+B7c1F9H88smMb71KzSugvOFAavq+Ti4H?=
 =?us-ascii?Q?fUCU8pkB9UghV1FbIG5OYDZJ0Agm6qpIQd9iWQNaPjazR5MU+zbrMCI30IoM?=
 =?us-ascii?Q?zRUjdfEKTk7u55BB3ENG1rvjfwHUPxDQMjw9IXBmwqGYyM1Z4c6ebGW7//i1?=
 =?us-ascii?Q?t9XMqOBI+nTiZ2ve5XONEiQD8W3lHzCkT/MDivr4+GJ/nMVwhCSpuUDkftRC?=
 =?us-ascii?Q?UxhSza6W9jPuHJ/iNcJKjVX2eFJgaJqyEOnf81YQGoNmZ8kWNPQJyX6BtOx+?=
 =?us-ascii?Q?zCHAlefp4VbZt99vunXNsXzuk+qdZvdN7erVBNh+f+lVnzVFi0vajbu50k9y?=
 =?us-ascii?Q?oNn6aUednM8YlcHBQs8U1fbZxurkDapuvo1Yf/licwf2tZTShPjuGkI+tWfX?=
 =?us-ascii?Q?YEk6kg2qPjzcXrA7TZbVzM78W3wSAIJuuZvso7IMJ7LyacSAfpqd8Ejl0r1B?=
 =?us-ascii?Q?kxO3vJmZcrwBKolXAUnKatuLLc/0bLEF9UjsVKAi4j0baK3E68fiLogCIOPs?=
 =?us-ascii?Q?Bw5RBCJwy32bmXZeTjEi0X34CyggRlQH5kMqlsfabe+VFD2C6dyjDPNKMKIS?=
 =?us-ascii?Q?MC6YbaeAM/gO3rs7PKRj9MnOVsa3VkrJkA1dPlJzbiYjzdgzTcrfxdRe47Sb?=
 =?us-ascii?Q?AX/7ndSNfJsPvd+Ap50WQhn9EPuR8ANY+3U+QqOW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0a44ba-1dc2-4513-394e-08dad49dbb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 19:45:14.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82jtOjKiHi4s7DwItZZJe0vIdTqHjqeZXWmEctlikmDB43ASGNngITdZjLYgP27XCH9nUmN08ApJPOL3AQt9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On driver unload any pending descriptors are flushed at the time the inte=
rrupt is
> freed:
> idxd_dmaengine_drv_remove() ->
> 	drv_disable_wq() ->
> 		idxd_wq_free_irq() ->
> 			idxd_flush_pending_descs().
>=20
> If there are any descriptors present that need to be flushed this flow tr=
iggers a
> "not present" page fault as below:
>=20
>  BUG: unable to handle page fault for address: ff391c97c70c9040
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>=20
> The address that triggers the fault is the address of the descriptor that=
 was freed
> moments earlier via:
> drv_disable_wq()->idxd_wq_free_resources()
>=20
> Fix the use after free by freeing the descriptors after any possible usag=
e. This is
...
> Fixes: 63c14ae6c161 ("dmaengine: idxd: refactor wq driver enable/disable
> operations")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

