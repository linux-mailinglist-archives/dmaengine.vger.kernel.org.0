Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A17AE72C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjIZHya (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 03:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjIZHy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 03:54:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D378F3;
        Tue, 26 Sep 2023 00:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCnHFsxvWODUGpn4MkhQuHPfCrBAILbH/N2IRwMJFjrN/Z9KAHWa5Wi6NarHE/0TSD3qcpwDyGuyNJC+eQYwWVarXfY94PTOf0TPXk//wWzYRt6ENbursYI3r+Jgu3za+4BH9Dsi7XtFOraFHvKAe5rfq+eter29Xn9TmVcArCEpm/wXvRwEkAjrvJPY6Q31LYmr1jrytGKaIpe9wYV5r03VXYbx7QzgWJkXlqjVN1we/BogR99G2N9nTFJz1DBjY09Gl1HY436M+eieKAusHLPI1q4GqgPrh3G3rehdk2EbeZ534f5azjnP+xBz3Z3FXgo8/x3eR4ih8VecLTkDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRMiE8/WgCGPs8cqofG1DY6miIMwzX1LvXLbTj4MFVs=;
 b=St1X9GDB8J7LUO+gU9UXPC/zm0D4V+P8mVBM744QbiH69cUMdGcfwsMi1i289P9YbbUS7O91t0rT3wmXe+91deCYark/cY2XlJFO8BPEzhPtf/KSmfNcyxc+GuMo7bxta6gTCgHpTLeqEAqkSlNHKpjgccukvfNo/XEo/rcgupFZ6T+lL9mKgbvlt6UTVnkdXbzhR3+QF4BjUD+/nsfimsrRkMjOS6ZXnQQYNz5kkCw+n3ktyOKVjxAZnthwh84ohw7ToruWMniBA149EPBfeVHvH8BbZJpODQL1s/6FNEqkeq10lpbcaY9bgvpvXtvmKioMAiti+Su4svuTtsuyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zigngroup.com; dmarc=pass action=none
 header.from=zigngroup.com; dkim=pass header.d=zigngroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zigngroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRMiE8/WgCGPs8cqofG1DY6miIMwzX1LvXLbTj4MFVs=;
 b=qxQjQ4SLo1EwKicoVOf4NUEjj86V6kwWpcu4iLKB7wa2GvZzDJIi74EpTcEXnrswumxMjwENWYCp+blMYFQaMFpk3VYtggQ45eleObIulQFADABG8EQ5eF5EnRqYBIP9SHfORtJ6kRJcwpw4gmkLZKrYJo+rUP0xNUDSglkrCaY/RAyXyNYl7wQ8snvncwRE16DQA6L65IFRTPmk3U2LmG8OE9U4NqxQIAi2uUeqs1q87NViHXE7XrxOiTPFfxp1OpplKo9OTdWy7vdfrcifQYvzso+eLTua9HeTiFTGHaCLDa7K8/nU1TFItqN7pBaOlddsX1GZrZ4SaUgrIVq6ig==
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com (2603:10a6:208:57::16)
 by DB9PR08MB8291.eurprd08.prod.outlook.com (2603:10a6:10:3dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 07:54:19 +0000
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::e955:6f4c:9b5b:2d33]) by AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::e955:6f4c:9b5b:2d33%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 07:54:19 +0000
From:   Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Thread-Topic: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Thread-Index: AQHZ7HFXCtmZOIdMP0ek3TzK7ZAfK7Amm5EAgASqfACAAXywOw==
Date:   Tue, 26 Sep 2023 07:54:18 +0000
Message-ID: <AM0PR08MB308978F82A48F664FA962F2980C3A@AM0PR08MB3089.eurprd08.prod.outlook.com>
References: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
 <20230922095032.GU637806@pengutronix.de>
 <20230925090546.GW637806@pengutronix.de>
In-Reply-To: <20230925090546.GW637806@pengutronix.de>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zigngroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB3089:EE_|DB9PR08MB8291:EE_
x-ms-office365-filtering-correlation-id: 2be78518-3e4d-4f45-bbb1-08dbbe65c9cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbCOuWCB3P3yoGhb+XaIwDwwEUkk5yi/WarKdIB0jRrfIMmqVIl2wTAtgbjWZkKxDako1z32E2Ap3poCspy1MkAHJd9MAU6tcccvG2Sx+uU51A2cnkeTb2qOhBTaBAnP67kVSAy2mMJClBaNLWnhZ4+OA+wnYFm2cEyKbTHHTZCKsNMahexr09qgHy87mUT7X36IuwclEx9pYbwBnarLBoZtYaZfJCfUngW2eG2cp0WD5nCczh7fqSjEyPpe3ZuD55MbYU2CI2HbPRJlYMXayU3riCtvbgkW6JVVlSpZIWOGkNft2vc2sJVqr+R/2s5tXMuCj4aPxfVWXVoDQK7EXVPGIo0IjSlXJ0J2ktSrRmjhLKEzZSR2yLZIwTFMd+e3S08D/CAzuvF+wqE99L3EoKQLSY3UPW+HOCmm+8QZnQILd5frbUhnig+BAiswt5dwGPGf21g+Axebim425OO0vqaOUvaTlO2a6KJT4N/Hih2XieyPb3VmZQ0DpwirVPuAkS3aWboubTifCb7HfGpuoVgr9d7SdCwABmKm2Z5MQDmlhJV10k4WS0b/VK+nlE81B0LEZmtnXQh7l/JSS4H81qcN/8oOEj44hUElq11szIJe32YIaw3wNkzl64TN9UDy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3089.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(396003)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(6916009)(316002)(66556008)(66446008)(66476007)(54906003)(66946007)(64756008)(5660300002)(76116006)(52536014)(41300700001)(8676002)(8936002)(4326008)(55016003)(71200400001)(83380400001)(33656002)(9686003)(7696005)(122000001)(6506007)(86362001)(478600001)(38100700002)(38070700005)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vMO1E5Ok6B3Ysm/yuCeI8zneJ++VpbXPF81BV718tqusdOA8WIg/f6RG5q?=
 =?iso-8859-1?Q?Dn2iq0H0z8LEJDFVf5wAIoI8hoHUB1w6mmzQY672m9mqDqdiLO/TooQRqe?=
 =?iso-8859-1?Q?NuOzvvkC8eYbap0q4TMT1EEekf9WISV5es7Ppwv4ERl42Bx4j7ephARRGK?=
 =?iso-8859-1?Q?PU6LfxrbTZUbOUW2kFPnS6aWDPBQl6UfKY4wgj17oGySncgbt0DPD/gzyD?=
 =?iso-8859-1?Q?GffFxUVo6baa6j7dDa2Nfeexzzi468FSrdFXc/Jim+6lr2bl4YkIFhlTQF?=
 =?iso-8859-1?Q?Aav/+htZDB8a2iJZ8mE7A801GgnnveQ8J+rHmZ2jUYCySX7DqZfTVybzsG?=
 =?iso-8859-1?Q?Yr4Cg5XPppgY17EUjj1IYwAKrG31kmALjONs+Mmp/MZmj1EhccyevILnCg?=
 =?iso-8859-1?Q?IEDAXxupIXm5iwBid5yM6GwLRDE5zMH1J4UA4cTAxQLtctDZZCGxN5wfCo?=
 =?iso-8859-1?Q?KT82tGJVTBPLEtAjHXz/4CtaeZ3s8aR5Q10LtOiN6/4Suy9WownFj8UvuU?=
 =?iso-8859-1?Q?x7Zo+W8L6uPyt/Kk53oyppIJeCp2E62qEADYMbcJWJdcnLoTuRTvvdNYR6?=
 =?iso-8859-1?Q?8gxnKiTu4+mhhtKZyMMivqymzKR/tuDJeTLjs52O7SgegNjJWscKu1F+8S?=
 =?iso-8859-1?Q?f4lLaw/Ruk7nEbQ9ZpuRFr/2mQkPHvp0Z5WraLqrMDUjHWKHowAZazKMr9?=
 =?iso-8859-1?Q?IKtk+CUyYOqfLmS6NpjKfzc1jEShDvIJizBWIt+xum4TgCWSJ5xcoUHvYX?=
 =?iso-8859-1?Q?pAIfXPceKnBZIg9rn4N6ByXg6xGFZfRwfks5FK9tW8vvnXEkvUeWd54PcJ?=
 =?iso-8859-1?Q?LrKPoLPDkR/MV9K7oprVPj4RXtml3hJy1XrPXA/zHBrMsXX7855vLqkf5m?=
 =?iso-8859-1?Q?+q6Fsa+JlciurApKI0J/d6XfjlquUCtDQ64cg9ZvKyh4LVyb6bGjs7BGuc?=
 =?iso-8859-1?Q?QQ+PODKxjtNQiW8H5PqZDcdUjfHWu4rpb8NWRSq+1mRuUmeJ5LtfiuflDo?=
 =?iso-8859-1?Q?G/HsKuTV5z88VeUwVXGMHlXnk/ApbWnaAoWIw5dGCgTKWIhh23cE8I6dlE?=
 =?iso-8859-1?Q?TWh8G7XFWu6f/1YXtcyw1eFQrh7y3Rv+UbYk3xM/Tuy5Te78N29ufEqop5?=
 =?iso-8859-1?Q?EFOBYvGcJ2zJi5pkfnZpmcJF5+0inOAzI+nR90H9BQTgaT6b7MpZ+PD9vC?=
 =?iso-8859-1?Q?2IwMSpFx4CiThjC1fwxIHqoG7e3YiXHFWu3D1UW3acVdO4ari+8LRAMGvE?=
 =?iso-8859-1?Q?zFWBkuo41Wwq4CHq+/oDaPvCTTXwTjPungZ+ubncrvQVc3531Rjx8kXWa9?=
 =?iso-8859-1?Q?a5AFP53d3CEjhCZk3nv3+LHipXbSUrEfXu5zZCafTd66+rUg6ftuDWYfTn?=
 =?iso-8859-1?Q?CxOrCFGclJ85xWYz/wIHPySPvnc2vhtunOcgOMuK9e9OQEH/pwC9F4GTpA?=
 =?iso-8859-1?Q?tRIvOfD6zsg1Dk11tZsNQzLfirrjaIlvE8sTYLMhJ1bT9CvHDXbwJdZuXl?=
 =?iso-8859-1?Q?1dhQgaPukeMr0j7N4tj+xvimikN9wKJnybJwu2RUfn3hwIOB1J7hVvQE2A?=
 =?iso-8859-1?Q?cHBJAaIFTo2apzOklI+WddMe54lbu9mz86Mr9VWYb+tNfoHJsi9fNa13Gc?=
 =?iso-8859-1?Q?syR9WOG8ZX4XcKZ6ZjWGSrwKgcpFXt+VdwfXYZe0JbNU2YiBtEUsfzOg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: zigngroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3089.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be78518-3e4d-4f45-bbb1-08dbbe65c9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:54:18.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ec7f600c-e944-4b82-8191-695b8f02591d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S72S9UyDMPqCt8B1QfoBC5utEw3I3IiECdg8hgKbhyOamXz8nJcZNUcuuJX5oTCWExkVnXHJrP1+6qtol/F/3DQMovkabt6OB4eFzaRhENA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,=0A=
=0A=
> I think this is a false positive. The i.MX UART driver makes sure that=0A=
the console UART never uses DMA, so it shouldn't happen that the DMA=0A=
driver issuing console messages calls back into the DMA driver.=0A=
>=0A=
> Could you give the following patch a test?=0A=
=0A=
Thank you for looking into this. I thought I had an idea of what was going =
on=0A=
but it seems that was based on some wrong assumptions (I'm mostly a Linux u=
ser=0A=
and not familiar with kernel code yet).=0A=
=0A=
I tested with your patch and it does indeed fix the issue on my machine. No=
te=0A=
that I have been testing this in a similar way as you did. The log message=
=0A=
which triggers this issue in practice is a rare occurrence on my system=0A=
because of its condition, so I added a dev_warn_once() to=0A=
sdma_update_channel_loop() just outside of the conditional, which fires as=
=0A=
soon as some data is received through DMA. This consistently reproduces the=
=0A=
lockdep warning without your patch, so I'm confident that the patch works.=
=0A=
=0A=
> I inserted a dev_info() into the imx-sdma driver and got said circular=0A=
locking warning. With my patch applied it's gone. Nevertheless I would=0A=
wait for Tims feedback and resend it with some more people on Cc. I=0A=
never used lockdep_set_subclass() and I am not sure if it's legal to=0A=
put it into the UART startup function like I did.=0A=
=0A=
Sounds good, could you submit the patch and keep me in cc?=0A=
=0A=
Thanks,=0A=
Tim=0A=
