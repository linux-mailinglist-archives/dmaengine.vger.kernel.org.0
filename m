Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011F3BFE82
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 07:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfI0FQc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 01:16:32 -0400
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:49479
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfI0FQc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Sep 2019 01:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acye+VaHHQKk0uQ89CZsfP7zpV4XX3rEwtyzcVqfwdo7rsTAaZTNaJxFnX9u+WhJLc8wKBYuuwzkxJqi0FtZNSZGVE3FvKQYsSn2Zfe3rWvUCCj2nxJ6GNPzLV0KZruAWLWb2ovQERKMOyoKj0l41RqmeBCBGj46tyYismPhbPjWUufO40j53QW997wcrgqHuxZFyO4rLGXeQW+ljLcq7XoyFwE20ZHG5sH3PX7964AjYQlzlwAiXJLBQRaUY1/EKZK4oHN03aAx/QvLnl7wzFjOmqmhNoXiQIfVjBOy2YqTlfwj5wc/GovrpcICeZxowshJ2sg2V2Z4/bAWHZ0KXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0nkfSpxXmskAjKclssFRus1nUaFo03Edek9uATJEXE=;
 b=CwILW6/fW858FYgt2EwrGQSShJY1NM9lkkz/kSFFedRZylyxzhO0tX5Eny5WiYKyp2mGTQ+uf8lxXLb+iD/JCXNJ6x3rtoqDn9qpe3yr6zB0N+qdXWP5FYoH202bXYhAiNat2XtkHf4glOP4Wv2irDN5ptMAS8kcf0bahdPMz8lL4c3fAerKH5l/eWk9gTHh1kbTuJmWW/rEOrytQyZpOFzv3VVcO2CxaDCR8kx9Au9fCHLhivVDJY9ZjKFoMc972xyDU6pG9aU2T6rTnepjRondJzzunDX92GPRdKM8QaCwR1bRfi+OHyLguu4ChwwiG9zLO/BUdXjrt0B9pUlDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0nkfSpxXmskAjKclssFRus1nUaFo03Edek9uATJEXE=;
 b=UkCdSl3kIwfpC5MrvlLv9QUf1R6/jBVXITXEJZz5Lwa1dqPkyEphETOJKlMhIEeuHIS4kR6YZylUYoWevRZqppUFC0aDhsR13NlUVlU2wWlv4C7zQ1x+q6o+O9sMAVcP0i+TsvPCmPSDhUSvDTxM0jr/UWX1CGr3aoBGd8wSAmk=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 05:16:29 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 05:16:29 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Topic: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Index: AQHVZAhKDg4F4xU8mE+kGY5hxnspoac9ALWAgACRLOCAAMLBgIAAyItA
Date:   Fri, 27 Sep 2019 05:16:28 +0000
Message-ID: <CH2PR02MB700025E26BBC12DA8B7DB6D2C7810@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190925210123.GL3824@vkoul-mobl>
 <CH2PR02MB70008CE8600D98753BE1CC97C7860@CH2PR02MB7000.namprd02.prod.outlook.com>
 <20190926171801.GM3824@vkoul-mobl>
In-Reply-To: <20190926171801.GM3824@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ace7f51-41f3-49d5-46bc-08d74309da29
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR02MB7000:|CH2PR02MB7000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB70009EE01BBCC3F4B29871EAC7810@CH2PR02MB7000.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(13464003)(76094002)(186003)(74316002)(6246003)(99286004)(66066001)(229853002)(66946007)(4326008)(66446008)(52536014)(55016002)(6436002)(446003)(14454004)(11346002)(476003)(486006)(5660300002)(316002)(76176011)(71200400001)(71190400001)(25786009)(256004)(6916009)(6506007)(478600001)(66476007)(53546011)(66556008)(7736002)(54906003)(86362001)(81156014)(64756008)(305945005)(81166006)(9686003)(7696005)(8676002)(8936002)(76116006)(2906002)(6116002)(3846002)(26005)(33656002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB7000;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5D6igR36sSHDjL9oR1xgqbZ2xA8Pf06oyk4E2yaPSlAP15S39WJvTqIkuhW5Qt2nyIbVVfJHuu9PBVovz4Xrc5CsjRzuRRvKTENB54vUKhtekDXrmmy1QZUVVoVzcqmTreImMwz3DDnrVi73WYr4SRoPiL/3PyAoqscdoV0vWxg3fL8RTZGA+F5NAI2hiMGhBke8QlcaItmjim9qGDUK3RlH3UIfYr7+VS+hdjvRtrrfrY2Svh6XFbjD4QRFcPfKb81NSejyfD888aTfx3fQG+pXSRpMvhW0i1n6Re0Ea0L+r6FsbDWtNar2jFUOKTzuCiKYaGrMgnVSYPizZF8JhCIUSM0AhaVkUPzHvsOztO+Z7GeuelbPtsH1MA2r4aynWjYwiAS5AJ4C5vfE0W/6eRCvi5T++At0TnNNUkp8Vak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ace7f51-41f3-49d5-46bc-08d74309da29
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 05:16:28.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1m7OkKO4BCWILw3jboRxr3OOcpGOcsbjMfbxeQNpaVyDkjXjzuOKGjXl9m+htkm2b2IeeL1IKrRmSBt3tfxcHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7000
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, September 26, 2019 10:48 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
> xilinx_dma_get_residue
>=20
> On 26-09-19, 05:52, Radhey Shyam Pandey wrote:
>=20
> > > > +	 * VDMA and simple mode do not support residue reporting, so the
> > > > +	 * residue field will always be 0.
> > > > +	 */
> > > > +	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA ||
> > > !chan->has_sg)
> > > > +		return residue;
> > >
> > > why not check this in status callback?
> > Assuming we mean to move vdma and non-sg check to
> xilinx_dma_tx_status.
> > Just a thought- Keeping this check in xilinx_dma_get_residue provides
> > an abstraction and caller can simply call this func with knowing about
> > IP config specific residue calculation. Considering this point does it
> > looks ok ?
>=20
> well you are checking either way, so calling the lower level function
> only when you need it makes more sense!

Sure, will do it in v2.
>=20
> --
> ~Vinod
