Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852442F9AD6
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 08:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbhARHzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 02:55:39 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:50707
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbhARHzf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Jan 2021 02:55:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsCouUbVHXpos78VElOtuqb9JY3codHXAilnF+HAyC5MwQJHiktaRMi/oIIlJwYud3kyXKc5MldWtgBBDqPzEDlLe7sFTwpgwkPR2m3XZ6ntXweXuUlorfRfr4aoVtShnBmkRevGxNNf93OTsVIY1mqHXDN0pmbCyfIvfhuYvpROWHKIBFymnNybQcl8bBVhj1VW/l3dkLipGLgdFdx/T84kBEZUBC6/72l++MgqA/MQED9R35oBX3RCjy1PDmDeDXdl7Ljmlm/yOOLgH4QLKwtBGLoDLwSFvbqdb79LnvQ/bMioJ7sCLJZv//brw83MS4k3ARGS2jHRC1uoWtYQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWPZR6UGyppnU4uG40L777asdKxFGCiJNOoC79P/I1g=;
 b=AC7QIivjE2KfHH34FLFab2VE6uPQE0n4h0EtCA/3V2vL4XARfkObh+5SXh47RzHQHJNxYmdQpN5GLsMtlxRPxvnQ0/Bp5Qyj6osiSrmK7QxJ+wN7PnB3OEipwbjFHXsJApP5IbZcXbLFC7CxyynQBHJDsOSNO7UcIr4wsZJZn3U5eP6HAoRnmpOaHK13pKnYTOljJY1Jjj7/V6dzXigloYwjjK2DWghxtbaSz/GsTaYJ1H/KVjjXcI3dHhydYqkEYz2QcLYGmZzE1jJSBMkpGphLMdBHlCBCpkhV0EMU6FYRfUN7hX31ej9Vbbk2TDycIWkl1LJFpUVz9Q0EBE6vaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWPZR6UGyppnU4uG40L777asdKxFGCiJNOoC79P/I1g=;
 b=BULAVkckOMS5U2qx/B/cn3orlXlbqQBDqRkp3kVJTIa8pWvcDNOjg7rBDxLjec6sydVYCFEVAeyQhcJCrvUq9Bzvj+lYqRhnsz7pBmZO3vfFkW/SVRdKpQGshoaMcwFOiM7uPVLfi6NA9lsLYGM3K/oJRqhsFZEy/R8kSSbpGbw=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by BYAPR02MB4726.namprd02.prod.outlook.com (2603:10b6:a03:52::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 18 Jan
 2021 07:54:42 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::f806:48df:2f5d:5a6b]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::f806:48df:2f5d:5a6b%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 07:54:42 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     "dave.jiang@intel.com" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Paul Thomas <pthomas8589@gmail.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Query on dmaengine: add support to dynamic register/unregister of
 channels patch
Thread-Topic: Query on dmaengine: add support to dynamic register/unregister
 of channels patch
Thread-Index: Adbtbu7SsRMuX5CRR2G1ymjprdASMA==
Date:   Mon, 18 Jan 2021 07:54:42 +0000
Message-ID: <BY5PR02MB6520E4FECB26ACD6DB836728C7A40@BY5PR02MB6520.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [47.9.132.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 690d888a-f382-487c-6750-08d8bb865088
x-ms-traffictypediagnostic: BYAPR02MB4726:
x-microsoft-antispam-prvs: <BYAPR02MB4726087402F8CF448274287BC7A40@BYAPR02MB4726.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7KB+fgHCXhH9ahjFh7M61/7TZKKKckRBroGdg21+qv76BVjHaDkhysTa+F5z1orc0CbgRDQwXCAWPvD4xqpy+Rh2kXaiTQhvXwTcwG5PrrHWYgGWKGiypHiOc46uUjHnHax5zAvGnIE1r8uiOrF9ll+AtFghqB7ETzpei+2PXZacviDR1WkBjB7wR4wWGhDeIjKbGYVdAfbJ0pEbGz8GnRLpzvVw3wqwGJB0n46FYFOz+i7ie36MLZIAAW4y4tLY+Cvc5tz9H4aqeWoWAM2pupe/Ab6cfoLCrc7N4owSZsTBclaiMWZsLHHEfeIFWUSO4jSxCyouBFNL7BfdbhVelWX0kfjkywspsUuTFDCo2O0ltJkC0psGzOa8KvVhxD90jZvE+clAaiSPzo7YRYT3FWL2hmot+4sWMtJdCUQNfbCXQOgxC3WQy1s1WfdeykCzozSmkJUAwFfqmMIFX4exQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(9686003)(33656002)(966005)(478600001)(5660300002)(71200400001)(316002)(45080400002)(55016002)(83380400001)(186003)(26005)(4326008)(76116006)(8676002)(52536014)(110136005)(66476007)(66556008)(66946007)(6506007)(64756008)(66446008)(8936002)(2906002)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yXEDimIpAX3zCzkKhDs6aAp3RB+lK0ABUvUyz4vCgDPg5241MxIm+mxXQE8m?=
 =?us-ascii?Q?fodB9GFUutHmAUCKsZW9u0u7zI5o1z/DU9AIBFG2fmdhMAbvfAmr9E9EJaNQ?=
 =?us-ascii?Q?ayx7WvdZUtvYBBRZU+uvo8rMImIxtV44YJYNQo1JDxiMUsQfSRFns6R4+rlu?=
 =?us-ascii?Q?vESEkeDKKa5GKj8HQuANmuqiR0lJLw4f9yzBQIYTmkOFMPSRKEdccZvCEFRM?=
 =?us-ascii?Q?T7U/kXpr9di1kNcaH2UHoeeO9TS3uqUkvZ0iTC0BKsnwSFN1w/e+uMNn/nGO?=
 =?us-ascii?Q?pc67mxoC5KPeSn1EriUlFpHE6PWFlz2j0B92DzMZ3+4Bleub+LghJRWtrQ15?=
 =?us-ascii?Q?fMEak3dVx5g+qq84rlQ3Loh+hcB/BWnZX4umFprRdgET+kZk+vWe9G3lvpO+?=
 =?us-ascii?Q?68HIFCC4jpuUKXJOh+wkuhzJx5vGIWRkUM24bTseRm5jVAif890pdTxkdmdM?=
 =?us-ascii?Q?nSno59Cd0qzcdGVjCLVPlVRBuZfgGJQFLR4bBmRM0WOxBHDHnVT+ZT0JeqaI?=
 =?us-ascii?Q?NOlzlJOjFd9ZNilT8eMHB/gFSZv5C90pDGg/H6dHcPsRVBqcJAj8wxaw5zWD?=
 =?us-ascii?Q?nH/wbVc0uenRfdQzhgW9WFCzgyx145ZA0CaXsRdLockHr3t4CPSlgMgHM4ur?=
 =?us-ascii?Q?FVsauCrKm5vuSv09AyLLbt1IYA+1Kv7ns2Rq5KSkVn/r0AOdIANY/bR+9Af4?=
 =?us-ascii?Q?NSRhQ559LBjFHxZhVXi0nkCvgQB5IDkP54YfrhKY6OjBKVVr+Pz5ljN3kxQv?=
 =?us-ascii?Q?bhLKWIgbXZrVZBAKKgZhBXG7GeCkoqitXzLc5YLGvvUcTnPDH0M0VGVCTQof?=
 =?us-ascii?Q?qP1s+GbmCnEVBOVDPT132un94MlLmAgjxSsZZXMmBhbv7kQJNAfOXrHy6Ufo?=
 =?us-ascii?Q?wW0He0aSdEjOvpBfVnf5pP9USyIpeCWMxv6oEKwlBDszRRi9XBSHEfqd4FlE?=
 =?us-ascii?Q?4WMYezUnmOdPOuiGiSzlEJEgC9yjjL4+x84RdRhRN1A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690d888a-f382-487c-6750-08d8bb865088
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 07:54:42.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AE5SCQFbsd/n4NeUn08QH4Ozbl7UM0i1HCPIICV9jFGysbKmedpfYIHFD14w+aSke0H1Bi/VZw03fXCxY1RRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4726
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

I have a query on below patch (commit-e81274cd6b52). It causes regression
in xilinx_dma driver and there is a reported kernel crash on rmmod.

commit e81274cd6b5264809384066e09a5253708822522
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Tue Jan 21 16:43:53 2020 -0700

dmaengine: add support to dynamic register/unregister of channels
   =20
With the channel registration routines broken out, now add support code to
allow independent registering and unregistering of channels in a hotplug=20
fashion.

Crash on the unloading xilinx_dma module is reproducible after e81274cd6b52=
6
mainline commit is added in the 5.6 kernel.

[   42.142705] Internal error: Oops: 96000044 [#1] SMP
[   42.147566] Modules linked in: xilinx_dma(-) clk_xlnx_clock_wizard
uio_pdrv_genirq
[   42.155139] CPU: 1 PID: 2075 Comm: rmmod Not tainted
5.10.1-00026-g3a2e6dd7a05-dirty #192
[   42.163302] Hardware name: Enclustra XU5 SOM (DT)
[   42.167992] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=3D--)
[   42.173996] pc : xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
[   42.179815] lr : xilinx_dma_chan_remove+0x70/0xa0 [xilinx_dma]
[   42.185636] sp : ffffffc01112bca0
[   42.188935] x29: ffffffc01112bca0 x28: ffffff80402ea640


xilinx_dma_chan_remove+0x74/0xa0:
__list_del at ./include/linux/list.h:112 (inlined by)
 __list_del_entry at./include/linux/list.h:135 (inlined by)
list_del at ./include/linux/list.h:146 (inlined by)
xilinx_dma_chan_remove at drivers/dma/xilinx/xilinx_dma.c:2546

Looking into e81274cd6b526 commit - It deletes channel device_node entry.
Same channel device_node entry is also deleted in=20
xilinx_dma_chan_remove as a result we see this crash.

@@ -993,12 +1007,22 @@ static
void __dma_async_device_channel_unregister(struct dma_device *device,
                  "%s called while %d clients hold a reference\n",
                  __func__, chan->client_count);
        mutex_lock(&dma_list_mutex);
+       list_del(&chan->device_node);
+       device->chancnt--;

I want to know some background for this change.  In dmaengine driver -
we are adding channel device node entry so deleting it in the exit=20
the path should be done in dmaengine driver and not in _channel_unregister?

NOTE:  This issue is reported in https://www.spinics.net/lists/dmaengine/ms=
g24923.html

Thanks,
Radhey
