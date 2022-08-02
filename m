Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C958761E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 05:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiHBD6M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Aug 2022 23:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiHBD6I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Aug 2022 23:58:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170481CB37;
        Mon,  1 Aug 2022 20:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcRcAaBulbC6NmWkraxv0n2obpmVpG9lJUTmW0Aq8J1zKjC8ETgfItCHS4ee50oXqqoxYBHpv+LMoVPRyE1mOt40O0+Zdq/Wh62OyZg0DkXDZ4H5GhvUvMF99l/Rm0y6zBhxYk/oMnUsRXY2usM5oUAU2c1pfmg6GoAV+nxt1sakJ7g1a9juwia2t/h6mZYV4s2jSCuBYRbyib8PKnAjeZZvH/9a3ODGlXxtPRcxNKuXXrIYWUWQOqYLNXmJStFPmZxYuLw0cDDBCtpL+Cg3tuTFgPwV/b4W4bSIFamtvRr27pV32kUBvxKuHBYhGaMMb1bu0CjIoMd+Vmw5Z7RBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOBDvvQ4HlAvg23bMBoclAacQoI9NJ+GIerHnJCPz8c=;
 b=GZRBipmNuw7IGEWbCkbsOH3RJzqpF7QDJ0oF7TUK0bve7DplNztSsSL5xsYsnRE4un2U2fHGShvOq2lmSojmPKgilK3DkwUcDJQX+lPV/ItMqWoX3+KM28MxTTwxUb4JEwhOEh2dMht7apZjQIVP4eLD1aayutOVNNNMN0JHUVUfb2YFljxdkff1CYxQjwb0onCEuIIK/T14NOPcS+ILhxMj9/YV111zkfgzOv2ISObVoh4XrSw5kK+D2LNfT3HfDx95xwLX5/uGoqghQe4AHBN5TNeAV0I+/YeFyadAghYpMzZLSAc6PbWPqJWKGR0zD5EFM0JQnvEcILPXjYPptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOBDvvQ4HlAvg23bMBoclAacQoI9NJ+GIerHnJCPz8c=;
 b=IHq8RJdsIXVn7WiRZgcXfuSL54rTfLKny7ITPgmGo9luCMFVHN28eKVVWqXSnvKi12oTxeZn0aaqbua1baN5qk7RNHVM15jWvd0ciPBlOUoTlPcju0TsKlhUgaYVwaznzE7tjPZX/fMuHTqcywOqeJKR6fa/vtc7km5XvHEhkhU=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 03:58:04 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::a88e:aa50:65d9:6206]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::a88e:aa50:65d9:6206%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 03:58:04 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: FW: [PATCH V2 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [PATCH V2 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYb0UDxQBEoTyE4k+etryTbMWZ662baA4Q
Date:   Tue, 2 Aug 2022 03:58:04 +0000
Message-ID: <AM6PR04MB592554C5B222B1AF221C5E2FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220524080640.1322388-1-joy.zou@nxp.com>
In-Reply-To: <20220524080640.1322388-1-joy.zou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dbeea35-23de-45e8-697a-08da743b33bc
x-ms-traffictypediagnostic: DBAPR04MB7334:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlw/N8rLWhJcb/UARxfXF9CTUbJPygDyMARVvSbx4VN+1hZKUTmCfpC9sxdL/7ge0uWMjQJa+yaJ4t0RYwWFbSD0i0xYtja96TDwU77X4s06AhuVXUWC8HXid2M3Lq1bXo143sMj5aQGOD/KqrhKzVuP16exiHhmcyUT7YWCeFVDCEEUjhqxzdR0K45P/nVJGuP/0ZSKYlJRGYXH1ioQFfhctERveiLOp7mJkDbJGKbCLmd9oeEUq6lsY0jLVQGS1xuBKJ5ugvy3fuYNoEucQcS3jepQLwsBCGdkuPVD9P1xllKBri0SvpiUBBP3l7jnSwkcWKK2rQfxQLWZUlfDm1Tfc67JD6dhAu9hbBsDjm6HykM2z/FTxxbt6celXQ3C0jLJjmrz9BEBkQOZww6LrvygG6H/PDspMKW39+YVarTXal47CiVyxPhUYO3BOYrOdBxYegLI+jLKYHEGRDM2Y+ZA5pQ5UuDrf/KsYbcvewy8mk+3xUJ5KwKjSAOOXYtEcFfbZREct2gz8fvwAfBgQXSy0o7T37cYNsl9TgdbvHmp8Qfg9SoOhPYHm9kHQE1duvEOcM+NJWemaZAyslqxP7yC+KlbLISptnimkoKYbiDsWhKb5M9OnxDNXnWieIISCvbgBQKsFucJprDbVyQFgpMQ7g4ymxdv8dggPlWeM3L51pfgR+Nm2e8e1EE4ZIM8tgoJuN6mY6hmgnFn2Dlokb4kUH0ny82YJ40uUwkRzofewgWPMqZTVoBvtW3hI8ISE5Y1oi6lh7CRUtOxskP+JLXJTWyB9425vtpu0qpx6wdQvak8FOpBtjil+ylL0C6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(86362001)(38070700005)(38100700002)(122000001)(8676002)(66446008)(64756008)(66556008)(66476007)(4326008)(76116006)(66946007)(6916009)(54906003)(316002)(5660300002)(52536014)(44832011)(2906002)(8936002)(53546011)(6506007)(26005)(9686003)(186003)(83380400001)(71200400001)(41300700001)(7696005)(478600001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aDNqRHFFY0tOSWFDdzRaS096cEYwOTJOaENNZkN0aC9ZcWxMd2dDa2djRDF4?=
 =?gb2312?B?Ykk5Wndyb3c0K2phbHpQajFWdE01clRYMDNRd0tHN1FIdm9DVFlnYlhyY21F?=
 =?gb2312?B?Wm95eDhwSmpGSzFQa3c5amZrVVdGN0kzdVNxOXhmN0ZXeExEYVNKRFdaSzZY?=
 =?gb2312?B?NTRHNWJJK2lhRlVkR2V2VnlvdEQ5WW9nRy84MHAyaHphdzZ4NmJHNGg4YSta?=
 =?gb2312?B?NkNyOWJFZ1RtRk9FL09xbXBScHMvZXV2dWhwV0JmNW4wOWdQZGVhRnF5cExO?=
 =?gb2312?B?M3M2Vk9kQmtJT3NmSEJybzVNblk2NUVZZmQ0bEk4UzI0ZFFDVitDNEN1bzF5?=
 =?gb2312?B?M2V5Ky84WUowVkVMWElzR01ZTHZxTS9JcEJod1lqbzZmVGgvVG1memJkWHlu?=
 =?gb2312?B?TFdVb2ltUUdNRlhIUWJVSVh1VmV4RWZoQkRCbmtDRkZhYVd2L3J2UGpaUGI2?=
 =?gb2312?B?TmJFd3NLeDVVUDQ2R3dzQ1ltNVkwZ3FEQ2xXUkgyZ0NZSW5EZjl1QWJEbjRN?=
 =?gb2312?B?eFZpbGx0L2hxVWdtdVZDVTh1SkxRZy9CVHA0Q05BL3ZXZUpXWCs2dXM2ek1t?=
 =?gb2312?B?eWJ3d2VlVjNoTmg1K3dFNDQycVVvUnVEaS9EM0lEYWhWb1NKTFZJT1ZOYXRz?=
 =?gb2312?B?dGNaQ2l2dzB1UzRHdWF0dTA0QnBZUDJtNnpwSWNKRVJSSFd4VUlGbmtXUzFB?=
 =?gb2312?B?SG1XMy9zMXZYK1NmS1VDTDdJY1R3aWJacVVaZ3JZbUQzMEUvLzE5aE9Mdkty?=
 =?gb2312?B?cmFFd3RrUGk5Wis3UzBlRUtaejF0aDM1ZTlqaU4xcFpSUm5mMTRjYjVndSta?=
 =?gb2312?B?dlpjaWwyYXFoMnJCZ1BmMHZFNnY2d2dONjBVVURYdHBRVUdJVDJZQ0F0ZkZk?=
 =?gb2312?B?dTE5Uk54ZzRxYnY1aTJWREF1SWVtMmpZc3dkNEFSWE1VNnlzQnM5YlRxR21T?=
 =?gb2312?B?ejdDejYrbElkU2FzeTZPZU1LdUdwYjRwNHpkWW01djFBaE5mcUljSzQyV3Rk?=
 =?gb2312?B?QVh3SG9wbzZPc1JNdytxSjgwMDVyaVZyZTZyWUx5b28rMWZLWC9ZRE9PbkhK?=
 =?gb2312?B?dDNabU1vMHNYU09razNSdzhlbitXT2p5UkpFUm1KUWduSFFTRkUyME85UVN5?=
 =?gb2312?B?NCtKaGxsa2xWdzRlcVdHL1ZRRkY4ektETGFCRjJDcndaV0RFQlFCOW1obGtm?=
 =?gb2312?B?TDJFeGIvQWhBYUNlRkNBQjI1cWdNdk1hN2dBQVV3QWpJQko4N2dqWnpXUU1q?=
 =?gb2312?B?cE5oWkovajVKdHgrbk03dHArSkoweGVNV0JYU0NsMlhaYlBvRXIyaEdZWUpX?=
 =?gb2312?B?SWgwOU9YZC9lNEtpQWFybVFDMkVPajg1MFltYnc1NXVKUnkxa09YVnFuOGx3?=
 =?gb2312?B?aTRSZkxMU1hkRzB2RnZHZVlRRnA5ZDRxeEdNKzJqUTR5R1VtSG9aS0Y2WjIr?=
 =?gb2312?B?S29WZFI4MVgxNE4xak9zRldBcVlCemtLT2ZzZjd5ekRlOGNMdWJ1eEhnRHlp?=
 =?gb2312?B?RDdIbzhGbkZ0QWJsRlJTbTBvalpQUWRPdXVXb2RzR1Q2TW1sVk5vYzZ2U21W?=
 =?gb2312?B?WDVuUkpjbkx1enJxMldpRE1rZXlUV3oxRkNic2dLNkN5YlFzN3poQ3pxY3Fa?=
 =?gb2312?B?ZkNJc1BFOW9MU2hjY2FTcEVYalpaRkQrTGxyd1NjejBmc3BTTkt1U3ViL2Zv?=
 =?gb2312?B?M04yajUxUEowdzhmZjl6VHRhOHcrMWVTb3o4TGpwVGtWN0F6RkxOdkVpY1Zq?=
 =?gb2312?B?REY1T1JSMlNVN1pha1JzQVNmY1ArNjFBRFo1NkVPaEkralY4elFtUHFCMkVO?=
 =?gb2312?B?SlVZUnBnN0RCK1FQSm5TZUpHOVUyais5NUlyL3U3azFhMWtISmErbVF5VFN3?=
 =?gb2312?B?QTF0SmlOaC92UUg1cGtvbStYK3dLVU82UHNxcyt2V2Nkbi9mbHNadStOMzRu?=
 =?gb2312?B?QmhCSXlEVkd4OTRJUjZlN2FaVUJVaXlUM04xYXpJVmtOTDVhTFFKSHUrUGQz?=
 =?gb2312?B?THFsQllLbHNjUGZHcWYzdFpnMlNWK2xCb3gzWXNmWlJibnQ0Mk5jM0xzcnBK?=
 =?gb2312?B?ZmNkSEdvbkNOcE53emsvQ2VWYWh5ZEtMa1pzR3FWQ0NzejVuSklCOGZQeTVC?=
 =?gb2312?Q?49I8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbeea35-23de-45e8-697a-08da743b33bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 03:58:04.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npd7slt3JtkHCHq7lpC5SxRwXFEuSOvGpRMA0dgdMq4BEQ7RIZP14RXOMfVhOmUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQlINCkpveSBab3UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEpveSBab3UgDQpTZW50OiAyMDIyxOo11MIyNMjVIDE2OjA1DQpUbzogdmtvdWxA
a2VybmVsLm9yZw0KQ2M6IFMuSi4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsgc2hhd25n
dW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSCBW
MiAyLzJdIGRtYWVuZ2luZTogaW14LXNkbWE6IHN1cHBvcnQgaGRtaSBhdWRpbw0KDQpBZGQgaGRt
aSBhdWRpbyBzdXBwb3J0IGluIHNkbWEuDQoNClNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56
b3VAbnhwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBzaW5jZSB2MToNCm1vdmVkIGRhdGEgdHlwZSB0byBp
bmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMg
ICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCiBpbmNsdWRl
L2xpbnV4L2RtYS9pbXgtZG1hLmggfCAgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNk
bWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgaW5kZXggODUzNTAxOGVlN2EyLi5lOWI4YjJl
OWY3YzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJz
L2RtYS9pbXgtc2RtYS5jDQpAQCAtOTQxLDcgKzk0MSwxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qg
c2RtYV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQogCQlkZXNjID0gc2RtYWMt
PmRlc2M7DQogCQlpZiAoZGVzYykgew0KIAkJCWlmIChzZG1hYy0+ZmxhZ3MgJiBJTVhfRE1BX1NH
X0xPT1ApIHsNCi0JCQkJc2RtYV91cGRhdGVfY2hhbm5lbF9sb29wKHNkbWFjKTsNCisJCQkJaWYg
KHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgIT0gSU1YX0RNQVRZUEVfSERNSSkNCisJCQkJCXNkbWFf
dXBkYXRlX2NoYW5uZWxfbG9vcChzZG1hYyk7DQorCQkJCWVsc2UNCisJCQkJCXZjaGFuX2N5Y2xp
Y19jYWxsYmFjaygmZGVzYy0+dmQpOw0KIAkJCX0gZWxzZSB7DQogCQkJCW14Y19zZG1hX2hhbmRs
ZV9jaGFubmVsX25vcm1hbChzZG1hYyk7DQogCQkJCXZjaGFuX2Nvb2tpZV9jb21wbGV0ZSgmZGVz
Yy0+dmQpOw0KQEAgLTEwNjEsNiArMTA2NCwxMCBAQCBzdGF0aWMgaW50IHNkbWFfZ2V0X3BjKHN0
cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KIAkJcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2Fk
ZHJzLT5zYWlfMl9tY3VfYWRkcjsNCiAJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+
bWN1XzJfc2FpX2FkZHI7DQogCQlicmVhazsNCisJY2FzZSBJTVhfRE1BVFlQRV9IRE1JOg0KKwkJ
ZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5oZG1pX2RtYV9hZGRyOw0KKwkJc2RtYWMt
PmlzX3JhbV9zY3JpcHQgPSB0cnVlOw0KKwkJYnJlYWs7DQogCWRlZmF1bHQ6DQogCQlkZXZfZXJy
KHNkbWEtPmRldiwgIlVuc3VwcG9ydGVkIHRyYW5zZmVyIHR5cGUgJWRcbiIsDQogCQkJcGVyaXBo
ZXJhbF90eXBlKTsNCkBAIC0xMTEyLDExICsxMTE5LDE2IEBAIHN0YXRpYyBpbnQgc2RtYV9sb2Fk
X2NvbnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMpDQogCS8qIFNlbmQgYnkgY29udGV4
dCB0aGUgZXZlbnQgbWFzayxiYXNlIGFkZHJlc3MgZm9yIHBlcmlwaGVyYWwNCiAJICogYW5kIHdh
dGVybWFyayBsZXZlbA0KIAkgKi8NCi0JY29udGV4dC0+Z1JlZ1swXSA9IHNkbWFjLT5ldmVudF9t
YXNrWzFdOw0KLQljb250ZXh0LT5nUmVnWzFdID0gc2RtYWMtPmV2ZW50X21hc2tbMF07DQotCWNv
bnRleHQtPmdSZWdbMl0gPSBzZG1hYy0+cGVyX2FkZHI7DQotCWNvbnRleHQtPmdSZWdbNl0gPSBz
ZG1hYy0+c2hwX2FkZHI7DQotCWNvbnRleHQtPmdSZWdbN10gPSBzZG1hYy0+d2F0ZXJtYXJrX2xl
dmVsOw0KKwlpZiAoc2RtYWMtPnBlcmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9IRE1JKSB7
DQorCQljb250ZXh0LT5nUmVnWzRdID0gc2RtYWMtPnBlcl9hZGRyOw0KKwkJY29udGV4dC0+Z1Jl
Z1s2XSA9IHNkbWFjLT5zaHBfYWRkcjsNCisJfSBlbHNlIHsNCisJCWNvbnRleHQtPmdSZWdbMF0g
PSBzZG1hYy0+ZXZlbnRfbWFza1sxXTsNCisJCWNvbnRleHQtPmdSZWdbMV0gPSBzZG1hYy0+ZXZl
bnRfbWFza1swXTsNCisJCWNvbnRleHQtPmdSZWdbMl0gPSBzZG1hYy0+cGVyX2FkZHI7DQorCQlj
b250ZXh0LT5nUmVnWzZdID0gc2RtYWMtPnNocF9hZGRyOw0KKwkJY29udGV4dC0+Z1JlZ1s3XSA9
IHNkbWFjLT53YXRlcm1hcmtfbGV2ZWw7DQorCX0NCiANCiAJYmQwLT5tb2RlLmNvbW1hbmQgPSBD
MF9TRVRETTsNCiAJYmQwLT5tb2RlLnN0YXR1cyA9IEJEX0RPTkUgfCBCRF9XUkFQIHwgQkRfRVhU
RDsgQEAgLTE0ODgsNyArMTUwMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9kZXNjICpzZG1hX3Ry
YW5zZmVyX2luaXQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQogCWRlc2MtPnNkbWFjID0g
c2RtYWM7DQogCWRlc2MtPm51bV9iZCA9IGJkczsNCiANCi0JaWYgKHNkbWFfYWxsb2NfYmQoZGVz
YykpDQorCWlmIChiZHMgJiYgc2RtYV9hbGxvY19iZChkZXNjKSkNCiAJCWdvdG8gZXJyX2Rlc2Nf
b3V0Ow0KIA0KIAkvKiBObyBzbGF2ZV9jb25maWcgY2FsbGVkIGluIE1FTUNQWSBjYXNlLCBzbyBk
byBoZXJlICovIEBAIC0xNjUzLDEzICsxNjY1LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2FzeW5j
X3R4X2Rlc2NyaXB0b3IgKnNkbWFfcHJlcF9kbWFfY3ljbGljKCAgew0KIAlzdHJ1Y3Qgc2RtYV9j
aGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCiAJc3RydWN0IHNkbWFfZW5naW5l
ICpzZG1hID0gc2RtYWMtPnNkbWE7DQotCWludCBudW1fcGVyaW9kcyA9IGJ1Zl9sZW4gLyBwZXJp
b2RfbGVuOw0KKwlpbnQgbnVtX3BlcmlvZHMgPSAwOw0KIAlpbnQgY2hhbm5lbCA9IHNkbWFjLT5j
aGFubmVsOw0KIAlpbnQgaSA9IDAsIGJ1ZiA9IDA7DQogCXN0cnVjdCBzZG1hX2Rlc2MgKmRlc2M7
DQogDQogCWRldl9kYmcoc2RtYS0+ZGV2LCAiJXMgY2hhbm5lbDogJWRcbiIsIF9fZnVuY19fLCBj
aGFubmVsKTsNCiANCisJaWYgKHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgIT0gSU1YX0RNQVRZUEVf
SERNSSkNCisJCW51bV9wZXJpb2RzID0gYnVmX2xlbiAvIHBlcmlvZF9sZW47DQorDQogCXNkbWFf
Y29uZmlnX3dyaXRlKGNoYW4sICZzZG1hYy0+c2xhdmVfY29uZmlnLCBkaXJlY3Rpb24pOw0KIA0K
IAlkZXNjID0gc2RtYV90cmFuc2Zlcl9pbml0KHNkbWFjLCBkaXJlY3Rpb24sIG51bV9wZXJpb2Rz
KTsgQEAgLTE2NzYsNiArMTY5MSw5IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2Ny
aXB0b3IgKnNkbWFfcHJlcF9kbWFfY3ljbGljKA0KIAkJZ290byBlcnJfYmRfb3V0Ow0KIAl9DQog
DQorCWlmIChzZG1hYy0+cGVyaXBoZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0hETUkpDQorCQly
ZXR1cm4gdmNoYW5fdHhfcHJlcCgmc2RtYWMtPnZjLCAmZGVzYy0+dmQsIGZsYWdzKTsNCisNCiAJ
d2hpbGUgKGJ1ZiA8IGJ1Zl9sZW4pIHsNCiAJCXN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9y
ICpiZCA9ICZkZXNjLT5iZFtpXTsNCiAJCWludCBwYXJhbTsNCkBAIC0xNzM2LDYgKzE3NTQsMTAg
QEAgc3RhdGljIGludCBzZG1hX2NvbmZpZ193cml0ZShzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sDQog
CQlzZG1hYy0+d2F0ZXJtYXJrX2xldmVsIHw9IChkbWFlbmdpbmVfY2ZnLT5kc3RfbWF4YnVyc3Qg
PDwgMTYpICYNCiAJCQlTRE1BX1dBVEVSTUFSS19MRVZFTF9IV01MOw0KIAkJc2RtYWMtPndvcmRf
c2l6ZSA9IGRtYWVuZ2luZV9jZmctPmRzdF9hZGRyX3dpZHRoOw0KKwl9IGVsc2UgaWYgKHNkbWFj
LT5wZXJpcGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfSERNSSkgew0KKwkJc2RtYWMtPnBlcl9h
ZGRyZXNzID0gZG1hZW5naW5lX2NmZy0+ZHN0X2FkZHI7DQorCQlzZG1hYy0+cGVyX2FkZHJlc3My
ID0gZG1hZW5naW5lX2NmZy0+c3JjX2FkZHI7DQorCQlzZG1hYy0+d2F0ZXJtYXJrX2xldmVsID0g
MDsNCiAJfSBlbHNlIHsNCiAJCXNkbWFjLT5wZXJfYWRkcmVzcyA9IGRtYWVuZ2luZV9jZmctPmRz
dF9hZGRyOw0KIAkJc2RtYWMtPndhdGVybWFya19sZXZlbCA9IGRtYWVuZ2luZV9jZmctPmRzdF9t
YXhidXJzdCAqIGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmggYi9pbmNs
dWRlL2xpbnV4L2RtYS9pbXgtZG1hLmggaW5kZXggODg4Nzc2MjM2MGQ0Li5lZjcyZTAwZmI1NWUg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCisrKyBiL2luY2x1ZGUv
bGludXgvZG1hL2lteC1kbWEuaA0KQEAgLTQwLDYgKzQwLDcgQEAgZW51bSBzZG1hX3BlcmlwaGVy
YWxfdHlwZSB7DQogCUlNWF9ETUFUWVBFX0FTUkNfU1AsCS8qIFNoYXJlZCBBU1JDICovDQogCUlN
WF9ETUFUWVBFX1NBSSwJLyogU0FJICovDQogCUlNWF9ETUFUWVBFX01VTFRJX1NBSSwJLyogTVVM
VEkgRklGT3MgRm9yIEF1ZGlvICovDQorCUlNWF9ETUFUWVBFX0hETUksICAgICAgIC8qIEhETUkg
QXVkaW8gKi8NCiB9Ow0KIA0KIGVudW0gaW14X2RtYV9wcmlvIHsNCi0tDQoyLjI1LjENCg0K
