Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6437C6BEBAC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCQOrP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCQOrN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 10:47:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D422A1F;
        Fri, 17 Mar 2023 07:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGZaIk0+vo/j/fewokFQUNSWdnt+VQCXhRKCUy8RQ10hv+2s7n/mqEPCrMm+FFPbgObjneqCNEvkvTcZmIs091GuTs5C4NKszW1+V6Z6EohIdLgjq/qLfjq62IQZL4eKZuPeTzDW9fIiy4aAJJQ2VUwskZ3WvcGBzOFgY+QkdItIcfhM+p+34FsR50PiudbktY3Nd1bhPWx/6Xhx6YrwTJyeds6BJP/GVYTsUASJwFCu272mdTFJt0ydolDfWhjE/I1TzkTBbyBTbYRCdY9/53bIe00UkJ+X82RkVbV2VOhtKOgXAelVS4pJytlrwaP0y/fSgaCKUsGE6gxjcTD/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAJyNsmED9B5fj7sMFgzFmnXHXNsJS1sfLeSudBgEI4=;
 b=PXIjNrPycDsNgYSFcbXBlOajl/H/JK3BzpNHfArQLQjV/F69/XcQfwjcGOej0mOWFs0/9lVZPf9gbQbSrOEDg78jRPeBz6pockjRbe4+ljxQ/hCforMKSATahyk0/4LpDKF2xSzOIsvM65xce54YxXY4jZRj2Nxq1dAkJynEmIHltfdcYxqRZsxkbTZncyNC1FCQLiElaH0AqZsNvGah5LS3flndhH+ApxUBZgs9h2pDdOhaGiLKp669E/p2RFsPZJedV47FI3Vt73JlVk85nKZuiUDSt8VbLDnRQBPRIP1QPcSnZgYNdPjGqpwSDZAiCT9qiTmf3l4pBlcxIj1YtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAJyNsmED9B5fj7sMFgzFmnXHXNsJS1sfLeSudBgEI4=;
 b=JbdzSynEvNyfriIQQUKU0KwogTgSsMozue3bAwH+bwMm14MJWmrJBnusW6D82d7slYiaTUkkS2EWALLd31kBvpQM9IIWOmVuXRMV9opidXjavNY8TpK4vBoaAj7B/OuE4q43PS/ttRQZKAj3KioZk01ozSTrEaiR7dbvnnewHiI=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:47:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 14:47:08 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common
 header file between endpoint driver
Thread-Topic: [EXT] [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common
 header file between endpoint driver
Thread-Index: AQHZWMRAZpxSPgbE9kOzF/3xKVztPK7/DA2A
Date:   Fri, 17 Mar 2023 14:47:08 +0000
Message-ID: <AM6PR04MB4838D8F8AF23C61048BDFB9788BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230317113238.142970-1-mie@igel.co.jp>
 <20230317113238.142970-7-mie@igel.co.jp>
In-Reply-To: <20230317113238.142970-7-mie@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DBBPR04MB7786:EE_
x-ms-office365-filtering-correlation-id: f340fd95-2706-4690-fc44-08db26f67c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJMlRsB+6haa7CTx0ZHF44J+yPe1AabWxL8IBq9s1fg1XAMvqt/9a57Ft6IrJmaQIbAr1puOO2PPMhzEevDjhodymm/TTECSHdrD/Iu+9eFAxASlP9k33Kk1AhOcqZEjtOPyxxCFDUY+4aoVVdl+aEhsGE8KebyfpFHagJOm4eWKvXVZipj/qkVjxaEh12YF5OtMD7L99/GFSs7OTHMqsRl7C8sETLsPFMceW5YtXs+j+qoZGHv0DLDaepvr5lvEMVFmyOrO3B7ygFR4Elzs0/B+qIVZE/VEQno1qEDcxbPvsJN8X3OCXuH07WOXcrEEw1dHo8cf5Bbt6Oh7U0c4HzN9g7hNv8vRt36X3a95Czpyt5z5mvz8REqwyzEjmwHZi5N3ecGscUbxJC6OuodxRsHj/BWNCqR2GwllAPcu21T0y/5ArXEjx0htZ3v/n9XuE9SgemcRhwXSt6h7oPy+P09Id6iEke7C7p8mzs+UAAYbwAAPQh7l3hUNJwGhhkDLGHneCxAO94rEMIJ8TMxvGgNgSYMOMqyuQnuJA8Lw52vgc1ky7LoBriH0JZvH1nxMe4RY4EE77alAJnnj5+6usg9tLSISYRmBLsqunjVk2sJSErECvgOJ1ap9reZ/m5BcP8rwSwVY1XlC/AmAAN8KpEHWkAhyG1kHSA67MftgEYdVxtnROUnU748PsR5YfN/4CjV0InlunObEJVAEH9amRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(5660300002)(9686003)(7416002)(8936002)(52536014)(38100700002)(186003)(44832011)(122000001)(38070700005)(6506007)(26005)(41300700001)(55236004)(86362001)(2906002)(66556008)(4326008)(478600001)(8676002)(64756008)(66946007)(66476007)(76116006)(66446008)(55016003)(316002)(110136005)(54906003)(7696005)(33656002)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?EEZgENb/aATAfDkMr4Odv/nHkWfzTJtHLfmEWqVDIV4SfC5NeJLILUrMhu?=
 =?iso-8859-2?Q?BLzS4FW4Ps3x2SjYZ5P//+JlRwKbAiKxY7T57DbP8Ot1BYGwBn8mOA7KJw?=
 =?iso-8859-2?Q?0m7SuR+7ekw0g4KTqQRcHVy7dwU2rS7vsx+HaKxiv4M0hiD/ZRi7G+qb73?=
 =?iso-8859-2?Q?yJ14vmj2CdWElVHga0YYceUBuPPSTRhf0/u4mKgbQ3dSNLRr+esuk53EM/?=
 =?iso-8859-2?Q?TL/uK/ke96mVuwjoFHIrh7ncR3BdGRrZDzW0EwS5jd2zVoqktH8fsKhsg/?=
 =?iso-8859-2?Q?ylbgZm1JBG9p4UE9ZRAK7LiQCa6qdFg9f+6ZxgVECngtiMzmcyK46hfGET?=
 =?iso-8859-2?Q?5LphcdV5J400BfGvmaJjoAvC5Wc+lrSdl273IuulL/2xj1X8hj9oVMFv5k?=
 =?iso-8859-2?Q?3Ps6nyUcFXbkY8bRCurIvn8/7Wo7l9t7uaQRyTOvqU9NZQt/4/SzMkYnJy?=
 =?iso-8859-2?Q?cNiGMJ6UjCRfgUMlA618Nqz4CsTA0vH8+0t5F7ZlVrD2AWpeooFMDM5GRl?=
 =?iso-8859-2?Q?c1duCcjtbps9d5zfV5hhpuqRxxppdX7uGv4HL++zHE2WW7y4CRMFXzsJxy?=
 =?iso-8859-2?Q?c2K2O+933gEX2neZjwgsxZxXbFgaPliES7tH5NqjLTsfxyp/SrYEePTu0K?=
 =?iso-8859-2?Q?7cawTSLNOhe7YYw7YP8HgUJbwtBiz4uYkN4X4hEuxi15HJafOSrVUgCqOq?=
 =?iso-8859-2?Q?VRD5kPgqiRImf7xZkG24q36ywz2PzMX2U87UUUKHpa75kc1KKKcOdy4RFQ?=
 =?iso-8859-2?Q?7+QVXDQXTLGdf9kIwnBFZ1xV0aUyQr5jUdssKXFmHy263yMNq4DHwH5/tN?=
 =?iso-8859-2?Q?3f//n6Ualn1pKI0z3pltihuHra3Mz4QrwfSWQ2Wtv5qkXuUTm7m7b82UMf?=
 =?iso-8859-2?Q?B97CEs4kFeHkAn0pYLlAE3y5Ub/ZEfO2SCsSKWhjaGcD5THQZrdfAc5EZz?=
 =?iso-8859-2?Q?l8eGe7pPVjWkdFAnPczm6y8ZtiAm7hTi+BJnU2vUus2fbkuwGN9f8cab0s?=
 =?iso-8859-2?Q?Tr9Gs7YYuMf6qHjIqTEaAXxJ+jONccWILiMcBcPuV0jiymPekJCp3qJHfB?=
 =?iso-8859-2?Q?J1YA6AgHibwqsGZ44JHp08nge6KL86u66jvFclQK7MD/CCZssAIO4vgMxK?=
 =?iso-8859-2?Q?2XabNaGwV+5IIiDkogQkSLPnLcoqThji4hcuFek2+cjENkPG8ukJQOIIxq?=
 =?iso-8859-2?Q?zEX52bODNH/SpjqpB8UPxJNPAa6q9jkkSh+9n14Yb7HerNPn2SkaQ9vdhX?=
 =?iso-8859-2?Q?zqZp+aoIZJd2eOp0gL5ad1ULm0984QUdlBVAXpwMHygiFJd3e8b3N8aQ2v?=
 =?iso-8859-2?Q?YERlDcWYjXjlWyje4ouoRI+67R588Ay/RA5Bcp27xUfDZhBqBz5CDjFk0z?=
 =?iso-8859-2?Q?1E+cvVT16WCQ5kpQXlKBFk0mkWYcCkL4ay/9ZXvMqTnS61pT+WsdEuAb70?=
 =?iso-8859-2?Q?zh29OGBFZnyxCFyQ/e/K2WY0eQ/UxqoEv4w3FSYS8hfz6I3p5wACpk5fcs?=
 =?iso-8859-2?Q?J+7r/fB5ZskPmaC8qdYnhTHkj2820dioitb63wgMxzCkVBy/vmjEqDkNtW?=
 =?iso-8859-2?Q?9BWr9QOGpjhoILzwH4j5+1xG9458WsjmeWEoM4SHHzHjyNuatMMmhPRMNm?=
 =?iso-8859-2?Q?IldlSo8rGP0II=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f340fd95-2706-4690-fc44-08db26f67c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 14:47:08.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vJop6dMfZaQ0UOXi2o9qxVWm/mrrBgWCs7fc1nnaxi+51hLjzOAncSOZb2tO6IOBUHo8tblUFYs2+7nVudQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> pci@vger.kernel.org
> Subject: [EXT] [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common
> header file between endpoint driver
>=20
> Caution: EXT Email
>=20
> Duplicated definitions between pci-epf-test and pci_endpoint_test are
> already moved to a header file. Remove the common definitions and include
> the header file. In addition, the separate register address writes were
> combined into a single write.
>=20
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/misc/pci_endpoint_test.c | 42 +-------------------------------
>  1 file changed, 1 insertion(+), 41 deletions(-)
>=20
> diff --git a/drivers/misc/pci_endpoint_test.c
> b/drivers/misc/pci_endpoint_test.c
> index 55733dee95ad..d4a42e9ab86a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -22,52 +22,12 @@
>  #include <linux/pci_ids.h>
>=20
>  #include <linux/pci_regs.h>
> +#include <linux/pci-epf-test.h>

Pci-epf-test.h was only used by these two files.

Actually, I think move  drivers/misc/pci_endpoint_test.c to under drivers/p=
ci/endpoint/functions/
And shared one private header is more reasonable.=20
These two files should be stay together because tight coupling. =20


>=20
>  #include <uapi/linux/pcitest.h>
>=20
>  #define DRV_MODULE_NAME                                "pci-endpoint-tes=
t"
>=20
> -#define IRQ_TYPE_UNDEFINED                     -1
> -#define IRQ_TYPE_LEGACY                                0
> -#define IRQ_TYPE_MSI                           1
> -#define IRQ_TYPE_MSIX                          2
> -
> -#define PCI_ENDPOINT_TEST_MAGIC                        0x0
> -
> -#define PCI_ENDPOINT_TEST_COMMAND              0x4
> -#define COMMAND_RAISE_LEGACY_IRQ               BIT(0)
> -#define COMMAND_RAISE_MSI_IRQ                  BIT(1)
> -#define COMMAND_RAISE_MSIX_IRQ                 BIT(2)
> -#define COMMAND_READ                           BIT(3)
> -#define COMMAND_WRITE                          BIT(4)
> -#define COMMAND_COPY                           BIT(5)
> -
> -#define PCI_ENDPOINT_TEST_STATUS               0x8
> -#define STATUS_READ_SUCCESS                    BIT(0)
> -#define STATUS_READ_FAIL                       BIT(1)
> -#define STATUS_WRITE_SUCCESS                   BIT(2)
> -#define STATUS_WRITE_FAIL                      BIT(3)
> -#define STATUS_COPY_SUCCESS                    BIT(4)
> -#define STATUS_COPY_FAIL                       BIT(5)
> -#define STATUS_IRQ_RAISED                      BIT(6)
> -#define STATUS_SRC_ADDR_INVALID                        BIT(7)
> -#define STATUS_DST_ADDR_INVALID                        BIT(8)
> -
> -#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR       0x0c
> -#define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR       0x10
> -
> -#define PCI_ENDPOINT_TEST_LOWER_DST_ADDR       0x14
> -#define PCI_ENDPOINT_TEST_UPPER_DST_ADDR       0x18
> -
> -#define PCI_ENDPOINT_TEST_SIZE                 0x1c
> -#define PCI_ENDPOINT_TEST_CHECKSUM             0x20
> -
> -#define PCI_ENDPOINT_TEST_IRQ_TYPE             0x24
> -#define PCI_ENDPOINT_TEST_IRQ_NUMBER           0x28
> -
> -#define PCI_ENDPOINT_TEST_FLAGS                        0x2c
> -#define FLAG_USE_DMA                           BIT(0)
> -
>  #define PCI_DEVICE_ID_TI_AM654                 0xb00c
>  #define PCI_DEVICE_ID_TI_J7200                 0xb00f
>  #define PCI_DEVICE_ID_TI_AM64                  0xb010
> --
> 2.25.1

