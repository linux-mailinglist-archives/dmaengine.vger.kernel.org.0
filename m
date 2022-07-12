Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D162A57132F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 09:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGLHgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiGLHgH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 03:36:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93159A5DA;
        Tue, 12 Jul 2022 00:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUsBGWj+sqyZafQ/NtSQLHVgkVrWuFxg2nF9QMdhqV+DXEC3mAzJfszEg83DaCCbUUX8rRRKuQVVq/0U2CaSx9nrW0fiQLmEyqiAyVBR2txwJVrKBKQUVK/0pRMhJdZ+ZG4VO4wRItmW2R8Pzk8oaJl9P7u/dZNFbM1hZym1eQSG5szSz8aHInMvkPs20sxQLU+rKYHUjZg3DuqQSZQy8IrIUqz0R9SV5eMUZP25Pn5giOHJ4yHCVFn138zVP0VvssK7Ygk46XzWI76ULNUTCLQt4fET/JwabF3yOa+wjfrqXWfIoKu01jFAF3QXPTbpolmZusMN/62P7d8MbEK0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjrE0NOzoLLQgbZBMTbDRMCcuzY192z715l2SfaxvfQ=;
 b=JDmhUnZAub3cYkFdolseCdyBpGJ3jGhblfIrsv4ZwnB2ioUfjIj2rLcfOO+QbofyF7HuCRG9BHvZAfToDMAo0PzI1eTe6lYCtS0AQbKHXiksuzlNNBhNhGwfKMwqYkHI8Rht/ZiLhA4cwQuTWrQk/al+kFTkH/B63KE38zQQ4YU5Ys78jf4VQu42ObsJdAXBYKdSKsG+T9fl4lozrZknqxmUG7R/TuItoTY36DNysCxs/Yr5Jbg87g+aVeAbTpaybAh77KB+wKgu37NcsNTIyAPK9jalqyslIsBtG2DaAMMWS1Io/JwxnCQirpVbGHIZar1vjLZPctwDI/ftXtwU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjrE0NOzoLLQgbZBMTbDRMCcuzY192z715l2SfaxvfQ=;
 b=Hhd7lB2rcLldCvT588l/A7DkMvy4Ay2ZW1WUnc4oF5qgspivoy516JGy7Csr/ckmhGsCdEEn+olfxJUMzsTt31BskAp9TgBcc0ZaDflup6UdMV4acszxiiBNzUQD5K0OeoXX++EmgouVfDoWibRLQLrR/xQeyOP93B6vAu2QKV0=
Received: from BL0PR12MB2579.namprd12.prod.outlook.com (2603:10b6:207:4d::13)
 by MWHPR12MB1791.namprd12.prod.outlook.com (2603:10b6:300:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 07:36:02 +0000
Received: from BL0PR12MB2579.namprd12.prod.outlook.com
 ([fe80::c1d:6ee0:e3c0:a5a6]) by BL0PR12MB2579.namprd12.prod.outlook.com
 ([fe80::c1d:6ee0:e3c0:a5a6%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:36:01 +0000
From:   "Agarwal, Swati" <swati.agarwal@amd.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Swati Agarwal <swati.agarwal@xilinx.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "adrianml@alumnos.upm.es" <adrianml@alumnos.upm.es>,
        "libaokun1@huawei.com" <libaokun1@huawei.com>,
        "marex@denx.de" <marex@denx.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "harini.katakam@xilinx.com" <harini.katakam@xilinx.com>,
        "radhey.shyam.pandey@xilinx.com" <radhey.shyam.pandey@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Agarwal, Swati" <swati.agarwal@amd.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
Thread-Topic: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
Thread-Index: AQHYh5SqXAa4rjkWlUirtjLpFHV/061pcn4AgBD/wHA=
Date:   Tue, 12 Jul 2022 07:36:01 +0000
Message-ID: <BL0PR12MB25796644B683AB6FAF6BD9D6E4869@BL0PR12MB2579.namprd12.prod.outlook.com>
References: <20220624063539.18657-1-swati.agarwal@xilinx.com>
 <20220624063539.18657-2-swati.agarwal@xilinx.com> <Yr7fou17VkqOYV0V@matsya>
In-Reply-To: <Yr7fou17VkqOYV0V@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95c3dc48-2bf9-4655-c6a4-08da63d92bb8
x-ms-traffictypediagnostic: MWHPR12MB1791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh6Kx2DeoWKFdBNINzXRDFQx8L2aVSnfiftGQ5MQAcj90I5MXvJZl7NfUutwpq0Q/3WW8jy23W/gp6lpSiM4BAK8m54DKgqQSmZ4FY3QvVXKU+1O0M4MV/ewBg1+aBtX6DjR+QGSHaNYoH0kFcjCF/AOGI9DNL62HRt8kiJimMRP0H8aZWY3sO+TzVYgG0Cvq30OWScYdT2Rv2kXE6WXiD6pZnUU8RCqXxz1jA9BIIYlAxYJ1rCJqTN7FtIiSDowBQf5AwtMuv7l6SIE31Ik9AjYNKc/LYKznhBE//2vdKPHIMya7oUDvbnWYTXWaWNAzAnhEgj973UrCsgySuqx+VWGl5b29wa9pkfHbyPREsGC6/w+pLqIZQaDmbXwyXKSRunxPM3UNcWS7NkEK5y4Vruhgwe7b1JCyfa3zDCNz/1zVSkOtuFKA37ZHMs0osfcAp/MagB35bsic3R8haA4lDqhocluL/NP/pWxXtLm0ltsQVSsV26r+dHHrDFGlIe/NVcrfwRDXvJCaHj6MK2O8az20ZyOWmyeGEVMz4eQR2b5uV7QohcB1/s+TXN46EbRlADfsKF5fIFZqe/VlGo/C7rx7541EK4RWJkJZ1KUSfKm0QotqwCzrS6b4P5ShbguGk937DqUMICuRMicLfxDCIzerB7Qwn+i5iR2WhCkVBk//Py4RpsHEoh/pK4OaE71lJvV5E2wgQGQYiex8cliM+3sSGXoToTNd7wmjzWoStZ1fEXgmmctvZyoH3PuCzn1DCghy4G3m3wjDbE5n5PY6bImGg/OHzSSc7uABJe3qmHziLR2DVuSjw9zfCA7s+rG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(83380400001)(8936002)(52536014)(110136005)(6506007)(4326008)(7696005)(54906003)(71200400001)(41300700001)(33656002)(55016003)(38100700002)(66556008)(9686003)(66476007)(66446008)(8676002)(2906002)(66946007)(316002)(76116006)(38070700005)(53546011)(5660300002)(122000001)(86362001)(26005)(64756008)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9MXI20+W8H4bGhlfIZU94bCL1dPXkEkuOvYZwLafEJZ+K5Rm+hpp6nBgrhq?=
 =?us-ascii?Q?BSXynCUkzVwHW7XRqZMXHOde90hTmEP1R7uBePqGSPwCrfuYYxByuF36Gpl+?=
 =?us-ascii?Q?pnGBGdQiKibgAs8+MMLsOPSxDoQ3AeAZWIhpL6S5oio1NNC/Tlq1jWYYXQ8Q?=
 =?us-ascii?Q?TwkjTMQhhP57TTqZuFgywxXyX+zv5DUEsQ9SVvNwNk6ukS9MydWxO7CjuQil?=
 =?us-ascii?Q?N3hmBIIYC1a3ZPZwH0cybKU9tkqvtW8RzMt+BTFIIPIr1HKvJmr/+kmo2MVG?=
 =?us-ascii?Q?3tDhb0+EuzKgztw64spPFlIeBNNjoIEYNFWz0Bor236AfXJ3OjOIokZEfsls?=
 =?us-ascii?Q?yUpgdpnti968hxIvS94M00DHJEaA9CsXM4hDpru39D61KhYx/zmkHa+/zya0?=
 =?us-ascii?Q?Ro+8TNESKMwndCLPIusgvRpwZGStJGkrU6EIdssWlXja8LFxZWYq7CdAIpwh?=
 =?us-ascii?Q?zVm5BiJCpev+8b9FrgG8j3fH8CnipacVWJcsLD/5Uro6mcehShSpk+gCqgo+?=
 =?us-ascii?Q?ETkiri/5rRqGdrRoSn23GvUpo6ZrLiMceQbVGvr303ROAo578u53xb6v7WCz?=
 =?us-ascii?Q?efMTxCtobciA1hYDLTTWRYxAEPhPvUAGNu0hXrw7gytuq+P4w6BcOqm3lzIX?=
 =?us-ascii?Q?bewsdbgwoWOYizVkjywCuAvvaGfXbVsG+f5Wo6s1rUvpEGUpMujwXkUQmsMy?=
 =?us-ascii?Q?ijCYOaqLWoa4qzQop1cIWT1U1a6fQ9QbyM+HjoCt+N+hJsKdAZrs9YE1leT7?=
 =?us-ascii?Q?GDjaKcarUrRCNTsOT0yMj03QgvoajS+oDw6YkKuvBz6+kbXRq3IP2R0OHOnI?=
 =?us-ascii?Q?W5u3TATuHtpDJR+2jpyAPUksj2WBk3Bt4I3pRoD21ARvUfxocKJq53yIpZ6C?=
 =?us-ascii?Q?ogupu80JPdAhDb34jJTXGujyurqnGiprHNR9HytUrNjyrK/8xrg5bQQlQcC8?=
 =?us-ascii?Q?8m93aYfeD13yoYR9BLm6RJSjLrEsyDs30yEVD9AQBKV+Sij+xpJn8uBIrVKb?=
 =?us-ascii?Q?GlvAeD+VrHgx/XqU7VK5cXAhxpZSkI5H9M7wgfkIQkNc/UvE/1zQnzqNyD2l?=
 =?us-ascii?Q?WfceDUpO04rxjfp8Njy2N1JiEC1vyzWPBR5EakpT7ohELbGAVxkYmXT/1wf/?=
 =?us-ascii?Q?8KRRLqSSnPz8vPMyndexFP18encDKgBuVrOq7bAYdVei9Da5XNjRpD0H5KNL?=
 =?us-ascii?Q?uzvi3qpcvoBo+Th2JgNatHvtMxCbZrYdhAcirPmLBwfRQlI2OjGpHxfW5/3Z?=
 =?us-ascii?Q?sLeMSI3v6qCXI7rztTI95jduA60x14/27GI9u1wErWcOTfYEcOyeWzWAz00R?=
 =?us-ascii?Q?T61VMjGWfXXnL20hz2rqj7enOs0I1okOF5s1UNY9tnCitOUzypMcEnuGFu7U?=
 =?us-ascii?Q?Wm7Dxaw0F7Ki/3o7zZg7huikgV+eo47dQFoa9vWQ0AEbL6wtgGLRuWasTgYm?=
 =?us-ascii?Q?2Jm5o85s7yQhShYAusGgrCqqhofgDQl+iB/rTCYPqaRaweIJ8BEgGOx9BhmA?=
 =?us-ascii?Q?m/JWCGefkH+wi6vOcHH/YhF/W6YQg1bu+dcABw9ZxEfuxFaXLk4zC1neLq+3?=
 =?us-ascii?Q?P+pajycVuuRdkBsPhqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c3dc48-2bf9-4655-c6a4-08da63d92bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 07:36:01.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39/R+U9uvFlwdKBTnLVWXEdeMi/zm63z7gOzsBdc9PfjpTxl0sO0dql8Dt05SAxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, July 1, 2022 5:21 PM
> To: Swati Agarwal <swati.agarwal@xilinx.com>
> Cc: lars@metafoo.de; adrianml@alumnos.upm.es; libaokun1@huawei.com;
> marex@denx.de; dmaengine@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> harini.katakam@xilinx.com; radhey.shyam.pandey@xilinx.com;
> michal.simek@xilinx.com
> Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On 24-06-22, 12:05, Swati Agarwal wrote:
> > When probe fails remove dma channel resources and disable clocks in
> > accordance with the order of resources allocated .
>=20
> Ok this looks fine and the changes below..

Thanks for the review!!
Sorry for the delayed reply. I missed this mail due to some mailer issues.

> >
> > Add missing cleanup in devm_platform_ioremap_resource(),
> > xlnx,num-fstores property.
>=20
> Where is this part?

The statement is an elaboration of the previous one. The relevant code is b=
elow.

<snip>
> >       /* Request and map I/O memory */
> >       xdev->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > -     if (IS_ERR(xdev->regs))
> > -             return PTR_ERR(xdev->regs);
> > +     if (IS_ERR(xdev->regs)) {
> > +             err =3D PTR_ERR(xdev->regs);
> > +             goto disable_clks;
> > +     }

This =20

<snip>
> >               if (err < 0) {
> >                       dev_err(xdev->dev,
> >                               "missing xlnx,num-fstores property\n");
> > -                     return err;
> > +                     goto disable_clks;
> >               }

And this

Regards,
Swati Agarwal

