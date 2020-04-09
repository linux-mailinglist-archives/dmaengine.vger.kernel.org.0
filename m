Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC91A3056
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2020 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDIHka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Apr 2020 03:40:30 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:6148
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgDIHk3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 Apr 2020 03:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POuoZFr/o7+5B1jHfBFC5MD6J+XhKfqjlBQ6AksI6jkHmZZaY0Du+MVviLMfX7xev1xZQ/+fMRrae1DafBcdefY9zroEUsccxO0XTaQnB2En/JzKi1BAVZkjBMBoItYrmamOHEAXH/2DuinAEzMAUKoBmVkOK7WoupW6WbH5+fv+OuJTTKhmGhEZ4yFE1bW9pPISjV5fXtYaE7Mug1yR+/aKTxYTzjmaxmdtAYkn3aZU11xyFxpS7iaL69MdQAEnWo7uHt/GLYUNd7WZQ3tWASRDwYv66jwbFqwEpWXWbUPDFQPqgEAi5DDAtPnDrlImitGrtBuNICYFBoqXSeycTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsczNHIsgu3bZK1XhMbT5s5vci/iex7BpcyQiGUI150=;
 b=eKsvvlfYjqDCCCMtVFUR3Xlk0GtGRh0eVXO6VnCnWLcKnlRyyntcmdsTxh5pL7MHXh4VUa8OPthc2NlrSwpPQIQwlPXtA4ne50IgGZaCFyLJj4gHAIr625jST+dgvTl/5QlYC5dbBFGwtwQE38Y/8JM3ia5UPOLeZTxybl0LqJjQQ7/aVfWdZvDEE4SQ2Ydd9/fDWidJjauZl2ISzhx/ip2DE/J0H94Jgjcmu6cPS67rukMnf0hA/L/bypLisk+1jNoJkXEJALD0tdO3KCJmEtdQ7DwOdDVgmu2iFMecNUiGtsQ4IkElI3W6Rh3CkUeypquE6qpDFAnxlsWp/w8jYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsczNHIsgu3bZK1XhMbT5s5vci/iex7BpcyQiGUI150=;
 b=LitpeV7clMu+h2tYnKrLNbxFZaAuzaeQ2ohx7fDvwYmbeM73Z/bPPWlsQSO+pZOZFT+O8RViNFN3OZ8KYqnmUqATp6IMeak4dXvFpNfH1EAffygkJsso6Wj53vwdbzs9HlD/ndejTbdrx1WVkm6Cgim8i4SYO/KBWDatxtOF7oQ=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 by BYAPR02MB5301.namprd02.prod.outlook.com (2603:10b6:a03:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 07:40:27 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249%6]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 07:40:26 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Sebastian von Ohr <vonohr@smaract.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV87v41lTd1EQv20WfWLzX9IzVjqg7kQjQgDHqXwCAACmBUIABXaGAgABwzYCAABdgAIAA/BSA
Date:   Thu, 9 Apr 2020 07:40:26 +0000
Message-ID: <BYAPR02MB56385DD6F0CDCE77FB5B6D68C7C10@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <BYAPR02MB5638DED4EF67EB842164DB0AC7C00@BYAPR02MB5638.namprd02.prod.outlook.com>
 <20200408151926.11709-1-vonohr@smaract.com>
In-Reply-To: <20200408151926.11709-1-vonohr@smaract.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cbd632e-9791-4d73-0fbb-08d7dc594551
x-ms-traffictypediagnostic: BYAPR02MB5301:|BYAPR02MB5301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5301101DD36126551C7C656CC7C10@BYAPR02MB5301.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5638.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(26005)(33656002)(107886003)(64756008)(9686003)(86362001)(66946007)(478600001)(66556008)(52536014)(71200400001)(66446008)(66476007)(81166007)(55016002)(76116006)(186003)(53546011)(5660300002)(7696005)(6636002)(316002)(81156014)(6506007)(8936002)(54906003)(2906002)(110136005)(4326008)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNNROzP4BO8BSHSktI8y1kZrU4Dnj/D0Ejhm9EOqtEqxDHy2yJGVE7hdix+fTUzUEstyg0Sre3qNE5PdfAmBxm7R0bwqc6uK3vG0MmeFlGkbhI+GHZkYi8WsJmFaN1u67NWD7aTFqLW/jKTzMox4MNxqSOGUI4ZKU2hRCouHLJjBV/fhrSYQmoKb+q4Rqf5Uv/1H0BeGeuFbs7hSVpd5rqUTwbfpd9PKstz24AzFjDdiprr12JwNS5tdE5av+ckaSVmxTqrI7gLwB/OZ2+2B8db7blwpjHrP6W4tSEvKO1C6Nj5Tif54T0sB18Cudw7qG8SGe1YhNjDrkV/EkbPO09xJ6X2vKBOJxBh5uZnvyvQfsYufoUZgyz3JHTu3w8vnvDhpSMVxD8yJfznhGsedi+6+zoLy2bG17MCZYnF7gZvN+35ro2o09WB3FCdheIU1
x-ms-exchange-antispam-messagedata: IwCiDfZov0tlE3kv7sf/5RhRom0d23BdrG7YdYSlKSihubRY3NDyvGWYfDAoHggsVU//+8JpQrIShwpZFqfZx894AuxA//ed37Xh01p3RsQH8+ZBR0VEwQz2LeQAhDHTJdpZElZh3+rx/nLw2gOFGQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd632e-9791-4d73-0fbb-08d7dc594551
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 07:40:26.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfY/ptollaKXfAaT2Iy5kbAKmqTn3Z1H51+ldFHi6TlOT1Zb0k9y6sDJmcTEFb2xjWu6BRAzMSCSRxxvJKUVjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5301
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Sebastian von Ohr <vonohr@smaract.com>
> Sent: Wednesday, April 8, 2020 8:49 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; vkoul@kernel.org;
> Appana Durga Kedareswara Rao <appanad@xilinx.com>; Michal Simek
> <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty
> list
>=20
> I've attached a patch below. When using this patch with the xilinx-
> v2019.2.01
> tag I get a kernel panic immediately when loading the module. Maybe the
> exact
> components on the FPGA are also important. I have one AXI DMA
> component with
> scatter/gather enabled, read/write widths set to 64bit and a max burst si=
ze
> of 16.
>=20
>=20
> diff --git a/drivers/dma/xilinx/axidmatest.c
> b/drivers/dma/xilinx/axidmatest.c
> index 3d88982c9f7e..757bab152e0a 100644
> --- a/drivers/dma/xilinx/axidmatest.c
> +++ b/drivers/dma/xilinx/axidmatest.c
> @@ -407,6 +407,7 @@ static int dmatest_slave_func(void *data)
>  		dma_async_issue_pending(tx_chan);
>  		dma_async_issue_pending(rx_chan);
>=20
> +		dma_sync_wait(tx_chan, tx_cookie);
>  		tx_tmo =3D wait_for_completion_timeout(&tx_cmp, tx_tmo);
>=20
>  		status =3D dma_async_is_tx_complete(tx_chan, tx_cookie,
> @@ -428,6 +429,7 @@ static int dmatest_slave_func(void *data)
>  			continue;
>  		}
>=20
> +		dma_sync_wait(rx_chan, rx_cookie);
>  		rx_tmo =3D wait_for_completion_timeout(&rx_cmp, rx_tmo);
>  		status =3D dma_async_is_tx_complete(rx_chan, rx_cookie,
>  							NULL, NULL);

Still, the issue is not reproduced, but as you also mentioned it might depe=
nd=20
on design, exact timing on events, etc.  The patch checks active list empty=
 state
before accessing it so that looks correct. In my test,  it doesn't break an=
y of=20
the existing functionality so adding a tested-by tag.=20

Tested-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>



