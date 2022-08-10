Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EED58F482
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiHJWqb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Aug 2022 18:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiHJWqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Aug 2022 18:46:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7D26118
        for <dmaengine@vger.kernel.org>; Wed, 10 Aug 2022 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660171589; x=1691707589;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=p3VIMQiST2ZmlMSMugr5Fx5jC6drvO79VV2bgstLJxQ=;
  b=fXTZIrAZdk2mMUg7DOB+85rLMzSCyMFUrgqVNzS2mR43bH06GW14HMle
   oVUz6D2vav4Ta41HSFBpYjHu0IIT/T+UpGmWdBPE+v9JtI8xB3aIzNyWR
   ahtbzQ/Q1hiJdNmW/X6bdFgYNGAHo4XHpByw3J6fji7n/tjNrI2rqivKy
   O67z8xSdN8P0HY6cmg89ueBt9XCqS2oZvhpE9/nEjfSLdL8MZT2c6SQNx
   Ja2PJW6E2QsdWpP9gAaIGpzaPtGFFrl1tsBxmMX4lUa93Pzyu+hlraYsx
   vC+r+VNO+ddDKOk/Z/vIF4A8lk3gshG/8A5p+hbB8ySIU4Gh6Qw7I/2VW
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="185983061"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 15:46:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Aug 2022 15:46:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 10 Aug 2022 15:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuzV64gB0Lo+EYV8f3QIZ6W23lUDjqQxj357aRADd/IpKk/WyHvpOqVUowhaQ2FNrNJNs3691MnmyH2WK5PS+4VzHzcKIKpUZzyiuzh7wUDv10z8XSJv+Ld7r/W51zTdpxMpmMoG1s6cLvyMeqlSO+0hRVZkaynJwtIC+QkfhBuP3kw1FcbFZ/wx2jl9I6hm28dFLZys8mkKVG8u9D6Gsea03iNpuVKE7zZtcwziGhmmUq83cicu1oB2BbN+GjLxv/dBnu15dh3cLLR1zy99lzBB1uMpVuxijVSLGdJXNIKCPAqJwSImKQhcQHg4ZW9tuVie+4M5AWL+yGb9Wj1G3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3VIMQiST2ZmlMSMugr5Fx5jC6drvO79VV2bgstLJxQ=;
 b=La/X69BfFw/hLhGhCL0uLUCwD0k3LNr9mycg+ao9lihC0ax1zdD3MLcWpift4EeEQqRm1zO3xAUYEMc5GMoJxzlBOEMsa9qCpcq/c4mROLO/sh7/MMVHOXFJdI7HFatvLWhEqA1+l1j6Q3wthLjzvt0a4+jGSbA2X8eOhq7pEgZgrRksFK8+w0NvO/z4MsucLKOBLDJ3QIeD2zilnXDTssoclZGG4zpd5X7Ltq9u11rvAajEXy7LSEVxJxv3XxiyOvt82Ix4Uqe5UDpIjp40KgMwhzhqtlKPpTAcgjG+Bpyyo/9AI63/5Vup1cl69om5loun4FJfIdTWcvskzF8OqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3VIMQiST2ZmlMSMugr5Fx5jC6drvO79VV2bgstLJxQ=;
 b=oV8gwaoAiadQ4ZaNK+uz3VKdOcLj3GDTTF5zn5JeoXc7EU+JkAE5oZJQ9kihAUtEXMIZJ8YlpXnASojFnr2Wj5gtdCJJG/LwlMpR/YlWT+s18ogbeCquzkJUd1KrrzVsecrW1DhmHggkrr/VFzRP+vHl3pQLeOtbo2lEn1xRZZo=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Wed, 10 Aug
 2022 22:45:57 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5%6]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 22:45:57 +0000
From:   <Don.Brace@microchip.com>
To:     <dmaengine@vger.kernel.org>
Subject: Question about using a DMA/XOR offload engine for md raid5/6.
Thread-Topic: Question about using a DMA/XOR offload engine for md raid5/6.
Thread-Index: AQHYrQqYtMqDezz+6ke/QF4DNuLhRA==
Date:   Wed, 10 Aug 2022 22:45:57 +0000
Message-ID: <CY4PR11MB12385444DFDB1343F28A41B4E1659@CY4PR11MB1238.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4496cbb7-8a73-412e-d403-08da7b221742
x-ms-traffictypediagnostic: PH7PR11MB5818:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5PC4oYISLNWSCA8c5YFS+Sn430ahEAXt2+b9Y134PSwpVxTGTOCHLCRyRr1npGfl9rkJ4iu8hQiN+REOygCrA9RjXMQ1KXcPdMKJKPrPUI8cIOgVXjOx8n63BO5r3iLV4OUyq59SowYVWSvt3HlHrWXYYWDAJsZucgP/5MTplTyajVRAwIKEcH7FYfQcQ3ekkxIpXBaRTbw3NzvCIeQB7KqqoplUNjsWg4S4qGJdW9CxyHgENK6VNo1j69oinFs0P4jIe7qAeVeeLump4Hosyv09UP3L6GknyM6kxQyiKjy81ildTJrvndI4g0ne3n3phDDS8nWHlDDpmReVM4dN0zCYDpBZk+3fgfb6ipffSS53vh1YB8Qb+nt+/ydxlAbaCvDr5qXzFX0DYBTAVcySB60UoDYjGKKpsEDHDBG5FwpJ2fp4yZbeSXHF4v9RRSGqtk+stNZuwBT4ULhu43b58HvkwggKIWT8lNACzi3+A39Vk8UHX6z4kkjb2qerBU6RR4CDVVFpzYZpEF1rkMq+cMZqJJhL+mcKZMeWz7jBwLRkWDjclTpI/EqcZy+THC2l2L8cHZxF90mmMFhISVsJsdZ3F2XQRUFlUtt6E3DMs0Eqeb7lOFz0vFfn6Y+JygrX0RaZRJnm97FOPnBAEEA51uSfo5ZSG435ZitAfArGqHzFf+a2Jzr5Lo1oqOBT42DVODUyaNqxUprF6LmUAmC9SGwqjBcJ/Ag4OqQu+e/Zqivp1ts2LLRfm1E/DjUn2SNF9nJLiND0u7hWRgVihPnxRL+LTqVBV7AzZieewH774VSQ1hDTZtbEOTMA6C1okgB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(7696005)(186003)(83380400001)(6506007)(9686003)(86362001)(2906002)(38070700005)(33656002)(66476007)(66556008)(71200400001)(38100700002)(5660300002)(122000001)(8676002)(66946007)(64756008)(26005)(76116006)(55016003)(91956017)(52536014)(478600001)(6916009)(41300700001)(66446008)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmocqmSJnGxWfsqS389GwR/ngVVWGOP8+io8g4M34hmvmIqegfGk56R6Hy?=
 =?iso-8859-1?Q?U43eGwqQ1lVOLfEwIAiDhoYQcD78jz/YbeIprZFBjP92aqK5/KwgdnownL?=
 =?iso-8859-1?Q?dxPh3hLRiUxDBJWAyhhA9P81ejRG6hQs62GAeLpi47p7cGjVzTAt1fVbpI?=
 =?iso-8859-1?Q?XVYMQNCccEyiFHZcvci9zkklww/wmWMDdm8bypEJvb6kusNHE63tnHmNxc?=
 =?iso-8859-1?Q?QALEhWFoDqJVJdaXPWrJoZzp7i5HZuNnL9gFJPMD2Ef35GmKQdFI+LAVq3?=
 =?iso-8859-1?Q?sxpFDUCrCFVxh+6OtY5oZTsjU6mR5OqPH1AUlfHUVb5akGLGTv3IZLt/Ho?=
 =?iso-8859-1?Q?/Gn5/o+jbO3DA39wCgMsxhuEIZ482WKtfPJls1OrfwVUJ1xM9E9tb51+2N?=
 =?iso-8859-1?Q?Tri/Xpxxdt/XaksTHPNnmpchuoaNXmAfLl+or5P2vEOAT8bWwccrzfXY2c?=
 =?iso-8859-1?Q?jVRVL0otCLFbrcvjtMftmSoZi6wM2nZC/giW7UTSasakQJ4Vmy+LDDWBmi?=
 =?iso-8859-1?Q?RNq7gonZKX+LBqEhDumRdXB/GLVUJF9cIamGhqc4mDNrFkEkyl+mjwMrQn?=
 =?iso-8859-1?Q?Nknz8TXGCgXkwtZiSM0mve6VMk/UkN7MqJE203+1n+HmZO3kDqc8uOKqH6?=
 =?iso-8859-1?Q?uss1C3ruFBWjK/bLHZmW5t2L1pPCY89coUnIeHkutgFDw3k1h+j9jVGW88?=
 =?iso-8859-1?Q?ASeJ0Lu2tOwke31YEySgwj1c1O6pR9W1zeAWVpnfiLnLWXRwW8fkf60Uog?=
 =?iso-8859-1?Q?IOW3TXDQbaPiin9lu5pXgSJ2a2I1t+2OwpdlXgO/+YdIRcimCVSOlSiGMo?=
 =?iso-8859-1?Q?lTszUbnyY8fyzJaSh852jYpkSY4zwt46UfwSYEuGoxnVZHuacFTzpIZ7Qh?=
 =?iso-8859-1?Q?EgUqNOIFeXlFezY+8a9pwikuhOcx2yco3bJqYbA1jHozUlTGY+/tEq77bg?=
 =?iso-8859-1?Q?4Jza8pZXhI1B/fZeD2ampqe41dZg1rhoyVE2cpwsGZk9SzBlkDPH4ee4oJ?=
 =?iso-8859-1?Q?1AQZWrxotZ74278i/z/w5slmQLMmDMkeuPmpXJKWtm9N68hTG/oyDbNThW?=
 =?iso-8859-1?Q?NIALL5SaO/OeK23iSSPVfTY2n+m75vNKvSiyn+SlKbW3i9oAjq73i4wZcJ?=
 =?iso-8859-1?Q?ZRawSe1ZN2ZaRtYgKtz7rGxPQR1PujFJQehxvzeomiA8PtVXdpJ4CyToBS?=
 =?iso-8859-1?Q?zIu7KrYZBBYQZfYCUld9rNi8LPRKV618KQjLFZM9C3IPbKzlonqiY4xJ1u?=
 =?iso-8859-1?Q?HoWTnidzFSdC9TfRVePGYR0XhqHKpbCt7rhl64twio78Jl0/3u5MFAH+0M?=
 =?iso-8859-1?Q?UeiRCcyftJxNNDQ4L2iafpmo64Xg1oqiGwogKWAl3slaEOc241IMXGpwvG?=
 =?iso-8859-1?Q?L+aXPw68cl5FJJ7CUNV/k0lISljwQkFbgCdwU1rh1rG+RQYCSkZ5WP09XB?=
 =?iso-8859-1?Q?UusNYKFTe9Luv42aa8b/F17oaLqWBr+1LfxJUCZ8/j8IvaRY4LvoSWM3GT?=
 =?iso-8859-1?Q?wgrtq8JT8RlxyYmVYhy6/NYR6BsAJGbkuTUeEOIyxWz1Rc7CSUnaUxM7y8?=
 =?iso-8859-1?Q?oFiAJxDhCffNwwlGdGiZUcCkkr2uwlfcs8oDkTs6WSUNeCWAcKwy7NTKfa?=
 =?iso-8859-1?Q?eKpcsgTlZNSBmt6dDjEsuKeDZgzXpn1vm2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4496cbb7-8a73-412e-d403-08da7b221742
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 22:45:57.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+LwHqW5F52khWxEk23q2hAVY8WLmqYLlAiPaQBr4Di+0TRTtRztOAVN9eJK1CND+qqT7xyW0J96yYcNCIlfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

=0A=
I have been reading the kernel documentation about using a dmengine provide=
r/client to see if the md driver will utilize a DMA engine when doing XOR a=
nd Crypto operations. =0A=
=0A=
I notice that the drivers/md/raid5.c calls async_xor_offs() which is found =
in crypto/async_tx/async_xor.c and it is calling async_tx_find_channel(). =
=0A=
So, I think the answer is yes if a DMA engine is enabled in the kernel.=0A=
=0A=
Is this correct? I did some tracing while doing I/O to my raid5 with =0A=
crypto enabled and see the above functions called but unsure of how data=0A=
 flows through each driver and if I am even using a DMA offload.=0A=
=0A=
I have the following drivers loaded:=0A=
lsmod | grep raid =0A=
raid456 =A0 =A0 =A0 =A0 =A0 =A0 =A0 188416 =A02=0A=
async_raid6_recov =A0 =A0 =A024576 =A01 raid456=0A=
async_memcpy =A0 =A0 =A0 =A0 =A0 20480 =A02 raid456,async_raid6_recov=0A=
async_pq =A0 =A0 =A0 =A0 =A0 =A0 =A0 20480 =A02 raid456,async_raid6_recov=
=0A=
async_xor =A0 =A0 =A0 =A0 =A0 =A0 =A020480 =A03 async_pq,raid456,async_raid=
6_recov=0A=
async_tx =A0 =A0 =A0 =A0 =A0 =A0 =A0 20480 =A05 async_pq,async_memcpy,async=
_xor,raid456,async_raid6_recov=0A=
raid6_pq =A0 =A0 =A0 =A0 =A0 =A0 =A0122880 =A03 async_pq,raid456,async_raid=
6_recov=0A=
libcrc32c =A0 =A0 =A0 =A0 =A0 =A0 =A016384 =A05 nf_conntrack,nf_nat,nf_tabl=
es,xfs,raid456=0A=
=0A=
Is there a diagram somewhere that provides any details?=0A=
=0A=
I made the raid5 with crypto using=0A=
mdadm=0A=
 --create /dev/md/raid5 --force --assume-clean --verbose --level=3D5 =0A=
--chunk=3D512K --metadata=3D1 --data-offset=3D2048s --raid-devices=3D5 =0A=
/dev/mapper/mpathb /dev/mapper/mpathc /dev/mapper/mpathd =0A=
/dev/mapper/mpathe /dev/mapper/mpathl =0A=
cryptsetup -v luksFormat /dev/md/raid5Crypto =0A=
cryptsetup luksOpen =A0/dev/md/raid5Crypto testCrypto=0A=
mkfs.ext4 /dev/mapper/testCrypto =0A=
=0A=
