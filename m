Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2A640FCE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 22:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBVND (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 16:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBVNC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 16:13:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EEA1C24;
        Fri,  2 Dec 2022 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670015579; x=1701551579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VCWMHEH7ji638jww/leUM2tmMeY16TA0nnl+lXtMO88=;
  b=G2pM+4a8JvNUUsk2a7P/GAI9CfFPb/cwr1Fj2vDtkfS6F+HhPWMSiahR
   /gE6B3ipE51WYT+DHF0olqCWYmdjcaTGcMo6+fNsxqzW2QSLD8fluq//b
   RCe9WEVtHlQGv4zUGYeldgqjroPNjex+UZ4AYgSIKvDPCUU2vv9VEqI9c
   /kCn0p1h4kRUT1kQqzKSOqcJbOWB/fLD0XatqBeAHPpvltEGE13AnmsSt
   Vr+BK5mI3DYEUQ5OCIP1PO6bJF7dw5pYR76FFKQfvd9DptK2uXuxGuAj/
   N3rBehmmSOED8c2PNy6LdEk9MmOB7D+EUPuKWU7A5yejQmuHDRTBDBCiC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313683339"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313683339"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="708622293"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="708622293"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2022 13:12:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:12:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:12:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRDb4AkVGDeXwErGP4uTm9aCeuHrpIV0lZIWqhHEYFT8v4x0YsrOT+zSsh8gj/hCavuEWux+LT5LCmh6ZfFBLXUi1wJFelb2+id+taLKcIIZwvwV7seeIPTopE5GIUD055qzLlf7+DyxpLUcQjZHzSgvtiwZx644kO/9wGiVHpVBbrF2eAfxbUeiQU7pVdyu7iGU+aBa5llIBjkUxu3zw2O+jluPX3I+Y3zK9aBwe5q3aBvyp8gRHPBPJAzUasHObJN6z+0Kih62Pgbc0NDABLRpVe0l1up460rVWBy6WIFJIFyZ3cAzvVCE3cHSJqygldIE+wrk1HPa2OMBYcppdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBVcAVx3wFwZrBW/dADGNSE0BZR1ZjmTsyFIN8Y6x5c=;
 b=P9gRCdEUFoinrYCsixp8KBfr+BygHNJxjIkRszWtT9BlwMRRhEwS0OMrr4tWq7wGUS6o/XCxA+Z4OJG27kXBfDuMghCYS478B6Me0Z7S1T2HnrRJT4pLSXgyij+UQoRWbxTZozdYRT71UDLsPyvN7ObB5a22/vApy5MpXjYkRqWrv27VtcOasDIIyKkAUDmQV8AGWKdnjQq8fKrbvYzxKEl78pkotco+VC3fVRj71z9iCxPN2h/KYlI5nXJGkATQ2zmUlFOFpOl0hkgxCxqIV5UovpSHArMgwNA/94C5hZxZ3HUxFGe5KdwCSldO+zyFPkXGiiBy9DkW7NUMO5LvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 21:12:51 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 21:12:51 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dmaengine: idxd: Do not call DMX TX callbacks during
 workqueue disable
Thread-Topic: [PATCH 3/3] dmaengine: idxd: Do not call DMX TX callbacks during
 workqueue disable
Thread-Index: AQHZBnt1PdyLJW2z60eGK4vKGNplmq5bFvTg
Date:   Fri, 2 Dec 2022 21:12:51 +0000
Message-ID: <IA1PR11MB6097E887BBCE14CE2D47CDDB9B179@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
In-Reply-To: <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB7367:EE_
x-ms-office365-filtering-correlation-id: 6d22272b-6cb4-48a1-2d4f-08dad4a9f894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMRPajCjo7EmH54LTueXvm2x/PUjEH+4BXhFEgEzQx1GMccun8OmzS/WXvsgVH/bP2VJzUZN1toWuqdv0D8a0T5i5odqOmzSY+pq3qhZH9JcL5VSi0EU3BSIvjrw1zdwYyqDxvKxaR/V7JqkCbrE6AUtkrEBIUnTgyvCHEfHnmeTlVGyxOxJZmW+htAsaM0EAB6x8opcieF3j36fe0BnIvoZmSBs013CmtXfY0NqFB+WOnq63XzfyXUiRx4Ad65p+FtwbxlUbS9iklJKZUgNDtV0b418t9Dw5qZCS1fv8bNawH9hceYcGTWDdQUq1JcRp2EG+uUwBGtlSit8nf6rfm0w0Nl92G+K4ypymdZ8UXQmRiSGcpEsrF2LcbncF7cOpuEhaFDpzP7BRVYhlZ5P+rm+Ppgm4BMkHBsO1cMaWX2UN1r8mVJIRFDIeXqfKeb4QfAWH74xkGzHs/O+j1bhOaA7+1lOyqnUho0c/YMGQrS4N2cA57X1iQD1CNWeeb2jocIoMrdbV3NMV0rp6kiwXG8gdlITP5iSzIZwyff3qXvowCmsmtu5bLJNLhtk2FBSltuIc1msECyINsxuLsISPKA5KslnsENZFQ8FTj4vobYYHXHJSnKjPPCjPrvutuuJAqLVE4uD7S6lHoMGUsU49NzvcozwCkqkrW1tdz4zukXfDpykYshWLbGB/xf3XfRo0pjfhQkpXFK08Yd0YC3cNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(83380400001)(33656002)(86362001)(478600001)(71200400001)(55016003)(38070700005)(82960400001)(2906002)(122000001)(38100700002)(5660300002)(4326008)(26005)(6506007)(7696005)(9686003)(186003)(110136005)(66556008)(66446008)(64756008)(8676002)(76116006)(66476007)(41300700001)(52536014)(66946007)(8936002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1M0qPwpxu+DtI1Ddt3PoXo98l5RYAG7MXQNOOPL3l9xfP+bOrIUTQbDGEip7?=
 =?us-ascii?Q?3Lf4TAsCNkyLG2PcOjNKPaF58m6Q3WoiUf/v5/MKlY3aV8uxtf/krG6L3hYS?=
 =?us-ascii?Q?o5dMWCxihB3UVWC4KZ0FpXN0Za8hxKLZaxRlllzgUJthol524ypYajN21xTL?=
 =?us-ascii?Q?rVP3pvDvatdjD33Ta1LtaADa9Jb0i7rld7f9+Srs7j+H/QZHvkaIdJhhZMrN?=
 =?us-ascii?Q?5y2ykrxHdSt0nE3L3fCv/+mi9pw61YFa/HS6V5QK/+N3sYkysDJqqiuGzVO3?=
 =?us-ascii?Q?FpRqMUmCk5gvNfZtIV3MowjhyLkeFL6zodmfwL8vVT2IY5e83TvQ9+lyxGJG?=
 =?us-ascii?Q?QzYkUZk1q3g5yNSKU4reoKz6YRwo86nyW94v8cNrbjZUiywHdveF3Pe/JVMt?=
 =?us-ascii?Q?6pKAUM8gBL6/P890nduGJnq9fAIcEVMcQdwAq2kjKhDzClKlGQztibAxYYh1?=
 =?us-ascii?Q?LHgQcueN2Rw9t/l/iU8Hq/bQIySrdZcFAf+I43TAs+lSO00jXuot1nfFsruK?=
 =?us-ascii?Q?ggSNxF0uzt/WDDQy5KR9ELfsPNcd6snYmvYe4AGaIZX5vg11Cd8CDnMdJ1Pd?=
 =?us-ascii?Q?8fuDqeskE17039WkEKybdaaqKnMFXqKkFVKsOzPq9+4E2O6MU0h7Dbgt/PEY?=
 =?us-ascii?Q?AYrHmbyH3f6R7thFSCAuGoppu78HIOQ2RsbA5p8Dpi5CYeVHM5IlWQeCDzKu?=
 =?us-ascii?Q?OAzpmP6DNlZiy2AoBkdY7lV8ipwUm1soN+FRslDJzY9rYiM1TuttqylAB+wZ?=
 =?us-ascii?Q?yufbs/k/utag6/N0oX4DKxO3eHthC02sWXBkTjoMsIvoe+dd90yeKqkBoi6i?=
 =?us-ascii?Q?Dh2AckSnyAiVPiqM7j8xuoVRU9HTXw/FdKpM+qT1sBeFsRYcXnk312Z/NLZg?=
 =?us-ascii?Q?uXSYqBpqmVAbgyvi5e6iVzvYng3GbE8ye7HpowIkUUrGtE1YF9dADByhV2y+?=
 =?us-ascii?Q?UFK0NP1L/BFZNva4qATGiIviewGaEb7JMX1gvqW/7RoscRN1hpZDkFxIzePv?=
 =?us-ascii?Q?g8XjZ+yAvcNQu4HgUMKU+kdrgT1eJfuVhqQGQU5BMTKF9bSJR6YY9SXUGkj4?=
 =?us-ascii?Q?enq597gJJa9229JITsIOnplCbC8gm/QjLKAtCmxpcOZQQAr7P1SIh7h4O7uB?=
 =?us-ascii?Q?7P06btzyBSYhvqffQA4TyaSl8G2q6rocMO5qJPr31rXPL7zmovZHpthak6au?=
 =?us-ascii?Q?FurLDfcsSa2cpCP/tnR6QQx7ASy90uawIOSi6+puMOti7hXFoZylOiQNupDX?=
 =?us-ascii?Q?/BBb5t8zcAe6tBnxgHpt5t/nFPPrqZnqQFd5ESIQ2Uvd2KbNCA2ZyO2UhzU3?=
 =?us-ascii?Q?rcxVJSOjVXWtiXDzMjI3XoOWITdRwDDYPRttLu8Jez7Jp5yHvHkKgUKX8unr?=
 =?us-ascii?Q?KF9FJqWl9qDA1HjsLmjKjLa4Nsc18t0OeQOCCJx8r6e+a2XE3E8iOzvWjFal?=
 =?us-ascii?Q?qrlmbmcnY8sSC2nS23MqpeaWsZCeuFdMgfnR2A9huHnG47nh7co09BT1yKb/?=
 =?us-ascii?Q?1ySOwnbXUUhfTMQVmm0TQzPyZCw72tfwCIb6L0f0eur3rzxRhmrgu+kPHHza?=
 =?us-ascii?Q?v7aBLWKH2+p2Q3ec+uO4UwoJGb7d661ZY7F8cZex?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d22272b-6cb4-48a1-2d4f-08dad4a9f894
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 21:12:51.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oy5ya3PAjNEZqFRPZQXnA+g/Jlps4PpNyqqooTQzLHGowDCKKQtyOUmvimUehp4IhW0K6Nd8Exvx2BFj8q/khA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Reinette,

> On driver unload any pending descriptors are flushed and pending DMA
> descriptors are explicitly completed:
> idxd_dmaengine_drv_remove() ->
> 	drv_disable_wq() ->
> 		idxd_wq_free_irq() ->
> 			idxd_flush_pending_descs() ->
> 				idxd_dma_complete_txd()
>=20
> With this done during driver unload any remaining descriptor is likely st=
uck and
> can be dropped. Even so, the descriptor may still have a callback set tha=
t could
> no longer be accessible. An example of such a problem is when the dmatest=
 fails
> and the dmatest module is unloaded. The failure of dmatest leaves descrip=
tors
> with dma_async_tx_descriptor::callback pointing to code that no longer ex=
ist.
> This causes a page fault as below at the time the IDXD driver is unloaded=
 when it
> attempts to run the callback:
>  BUG: unable to handle page fault for address: ffffffffc0665190
>  #PF: supervisor instruction fetch in kernel mode
>  #PF: error_code(0x0010) - not-present page
>=20
> Fix this by clearing the callback pointers on the transmit descriptors on=
ly when
> workqueue is disabled.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>=20
> History of refactoring made the Fixes: hard to identify by me.
>=20
>  drivers/dma/idxd/device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c index
> b4d7bb923a40..2ac71a34fa34 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1156,6 +1156,7 @@ int idxd_device_load_config(struct idxd_device *idx=
d)
>=20
>  static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)  {
> +	struct dma_async_tx_descriptor *tx;

Nitpicking. It's better to move this line to below:

>  	struct idxd_desc *desc, *itr;
>  	struct llist_node *head;
>  	LIST_HEAD(flist);
> @@ -1175,6 +1176,15 @@ static void idxd_flush_pending_descs(struct
> idxd_irq_entry *ie)
>  	list_for_each_entry_safe(desc, itr, &flist, list) {

here?
+	struct dma_async_tx_descriptor *tx;

>  		list_del(&desc->list);
>  		ctype =3D desc->completion->status ?
> IDXD_COMPLETE_NORMAL : IDXD_COMPLETE_ABORT;
> +		/*
> +		 * wq is being disabled. Any remaining descriptors are
> +		 * likely to be stuck and can be dropped. callback could
> +		 * point to code that is no longer accessible, for example
> +		 * if dmatest module has been unloaded.
> +		 */
> +		tx =3D &desc->txd;
> +		tx->callback =3D NULL;
> +		tx->callback_result =3D NULL;
>  		idxd_dma_complete_txd(desc, ctype, true);
>  	}
>  }
> --
> 2.34.1

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

