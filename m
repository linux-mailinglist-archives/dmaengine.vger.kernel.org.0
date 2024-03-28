Return-Path: <dmaengine+bounces-1587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE088F3BC
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE82A3749
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192263B9;
	Thu, 28 Mar 2024 00:34:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DE36B
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586066; cv=fail; b=ZFElImJIi+gxaYJy75F3DHvjDK3Np8Ac5iUw8/PlTe1NDURHXOl65xDBiNe83aT3uTkeCqNyzJdh7HnMr4R8/qFRigmMb2brWtOE6cAWTuYyQJN9BWCmS6gppcW3xDCfQ09ElwyHNogin9FwD7p/WQMqo0e/LBbBSwSyeUlVt1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586066; c=relaxed/simple;
	bh=61LG2JOPA3WPzt52kKXfN5rHZCdVfuFXO91e84pu8ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCld6JyhT7ErAtXnFygNRmaCv8wxTYRGAAZN4yEmpyTsJWZnPP/yEmV6aRT4NYUkQLyasm/c+HkzUwx1Y3sG1WhxsEVVhiFMYU5rKWF4x5/qT+CiMlnNsq9kwDm4MNnWpiV5L/KbVGB3bMLLSELcpFdIL1iBBWD0iBaT1PiJ8mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iblylFhOR6SKVbXD39Qx+B26qm/JRBd/n6ked4zPArn9Wuf9KXio6UHezVVO+ll4vemFEvoWCHqbunQ9KGroO3B4Ht2C+LG8rdyiX2Q7iZl8yXLNhKYml5/nJwcyCys8b+mxDq1hf4UgC42CPNnBO4ArIxrf88+bvD9irmc3oPFXgZH++YfmZtxohzGmPi1OM4jsLmjJPtR2k2twIOjnLDjAqXadgklsdQvkJwUYtnKE0mfK9Pq/myUDiMD+f6z4up9eZ7UGziizvD5FOYt5QpqAUXxV8l3XyrYbZgVyTixRxlhSwqjYv/MOouk5eIHc8RAos7ZVlp931LxmFg0Skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61LG2JOPA3WPzt52kKXfN5rHZCdVfuFXO91e84pu8ts=;
 b=aN+lijSN+XQQyIOoGqbxsbwE+QVdM8oWtl6pHTYHbieRLLb+dUGe63cinYBt/LRsFSdhwMR8Lg9cvM1+1P1KayHKd9QHSkk8RfCrf6zGrmkL+4x15PO2d4mYkKmoMO+DL/uhi4VTZkEHG4kYXAnJl5Wd3DYlBilTy5D+LIaCVUfQKO37lsaZFn3I3iY+VUq3oi/Xdfi7t5XKlNxGRfCx8J3beJ4nquCOQayRmNNxuhrkwqvHncjP4TgGl/OyjWqgeGAq8ecAbRDYh1OjnSTqfaUsqTVDl7l+s/AZrNJh3hDwkZ5CcHGbpBFMdlOYrZSrbLJ1vtqxAnKIOxYrM3TdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1130.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Thu, 28 Mar
 2024 00:34:13 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::42d5:699:8956:2ebd]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::42d5:699:8956:2ebd%3]) with mapi id 15.20.7409.026; Thu, 28 Mar 2024
 00:34:13 +0000
From: EnDe Tan <ende.tan@starfivetech.com>
To: EnDe Tan <ende.tan@starfivetech.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
CC: "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>
Subject: RE: [v3,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Thread-Topic: [v3,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Thread-Index: AQHaEJbGDYjQWbA3IE+YYf9wDui3KrFNK/dw
Date: Thu, 28 Mar 2024 00:34:13 +0000
Message-ID:
 <NTZPR01MB10189497FEC4D37D38B8A94FF83BA@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
References: <20231106095034.2009-1-ende.tan@starfivetech.com>
In-Reply-To: <20231106095034.2009-1-ende.tan@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1018:EE_|NTZPR01MB1130:EE_
x-ms-office365-filtering-correlation-id: 3c60d68b-bc67-4281-65f8-08dc4ebecafe
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lL/9hCT8whZ1bVsxAZe+MOUqkfZjRiTG/OoSJ5iPiiNfkHZ1Imptr2LB7aMPzvDPllptcymM3TrVX5OawMNyTqY/jOlx8bdr8AGcvs3Ef5Zzcjv7Wulj2WeOkD9xY7Bpo8FeHq/FG8fN+QN1a1V6fG49nWK+oUDliPexNs/6Rr9fee1mzNhIIfz2ZUneAZ7J8W0HNr4IIarun0N5cf5AL9qo+df7a+s/QYtE0n5VCXlbZ01OtSE2ZVbURiNtGG/uCR8AakrujWywSwqoVqWfMrBvp71i1dgWjmu56tTr0f51ZMpBsJe+GD+dUkgv5fHd7lLPYTs8Vgnw4GKP7W7DZVZK+iXgxvqN/4XvGloPpwb8VXvd5/mqmdLqENRYbIN9TlBHFitZRG9zMVhw1VpN888yHR3YLCUWAzHkAXGL/o6EQ+I2h6UmQf5J4N9bZzM/wDOD6CoUFCw2beMGSQXvKApsbFaC9PykXn1OrlkoStpxhT54Hw7cx9+bepoi2skAx2h/dj/y5DBjpvhCRTHYt6YeTJviEgQVRonkku7j+/ObAbJWnyvBCgh5FnUGKvgEk3LldEYqV/z3+SBviXdDRWsUQpyA+6+wHZw0q3/LKe9YOl+jdvYU/ijB2l6xrcnQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EwGq70U+ImularsRVIXsdBOiKbZBNIrnE+E0eanrfZtq2wEf1pUxQ2Dh/A7R?=
 =?us-ascii?Q?k+M+TNv8GgEA9PsqQuKwXqI9v1xpfj9T7TSRYKwlLBRhvNrQ5YyibxyIS+IP?=
 =?us-ascii?Q?PZJlg8D6udOj6XdI3FYUcKKHcVVuTyhWuGYo2yBxQitsRsiKWnQPmSTxbiXK?=
 =?us-ascii?Q?wZ0brdMnfHaVhZJN0rruiIJuEfSM7CufBafxj+DwKVe7jivX5ESi3UWMBMb2?=
 =?us-ascii?Q?HRdSdmIqLdUJ0VUQoKssaHE/08jGWfaB8SzB/Gtjhu/tVbIJ9KOaDTdeQ2P8?=
 =?us-ascii?Q?MtQ8qUd+tXgLoJ7/3fCQxMc0HVzdeze12ZMeL4ayb6MG7IQYzaZClnyBUqPW?=
 =?us-ascii?Q?1ooOFtXbUc+7DdSBBkefvLJDA/lGsDlGRjuvxKACgeUW3T/mL3unh81uRt4A?=
 =?us-ascii?Q?lU+My6ueRuukLWnRQg30TZNJaPoGuPJtGit3JAHSEsyb7OqkUJfu9MBHjxKs?=
 =?us-ascii?Q?5GPW18n7c5rlja6eDdJqYXaP7EyI4X16AycRoDq2Xclw5HeP4yQfvTY988W7?=
 =?us-ascii?Q?7EtyfxJJpL7ysE4Q/WRV6sA9P1WFk14tGx7fSeV/OUTlECkODkmplER0Bedk?=
 =?us-ascii?Q?sNleSNLKKKB7Gu0JXpdtxVeiJYo+9uFLnyBtYbl3rQ8b1k2d+rSYik7kiDkh?=
 =?us-ascii?Q?3hPCIkd5WleCtdDzEuzrIAOemxsUENOCmagbKmDhHwEYY/KnZZph2nTL87ow?=
 =?us-ascii?Q?4tQ0y+oQ+Puc6/vxKq+z/uui50kUuXSGCCCeUGeZx4HhHPo1Tp/x7IS+18jB?=
 =?us-ascii?Q?Fl4Q7tawjb3YqHXyZOpaKCBmH03a+wYaGeBbwIqxk5Y34s2dLs8uRQz6Dkkr?=
 =?us-ascii?Q?LLmUYrF8MEeOIlrZvPDwEv9fKgtLhRFcaeVNEA04rA1oMmsMluM5l/27TXF9?=
 =?us-ascii?Q?PhRehxEoT4vy4jbe0hYt3cWIviwJzCI016tsdmUkuyQioDyf4JV/On/ImxDQ?=
 =?us-ascii?Q?sTtOTsE5dx9UB1VG+s3xMnzBLHm32H5F0TZVovkibC32V+qsIBZCPJdIJhrX?=
 =?us-ascii?Q?pbwK+XFbp/rqJNOUDoWWkXZYcPoSbnSGgpkS+OkAjiiF1Ra4S0MInBTP322b?=
 =?us-ascii?Q?6LtJs7N/+LE5UanSRMI/mqd7YcmsfqvhWE0iKfa7iexp4vEQAhAHYLwPCiIh?=
 =?us-ascii?Q?l3Z3ppa5eAGvF3DM6uc3lXNeyaqQ7oRdPXngx5LWARoMBulnz+KTXGEdzVE4?=
 =?us-ascii?Q?K+p6ZKKEWBBIP1RGIe9G3398X+jem4Ec6NZ8PGOBCamahGflF6sNPj9m0eJo?=
 =?us-ascii?Q?nYIUBl0B5fmx/rW/bqyjSiDIU+5xuNG27Q8d/zAdb2ni4fxLnnsd/GdfvprP?=
 =?us-ascii?Q?gM6n71nvz1nUjNIALK1eL+j/jC/HVIKhftvlwJGMH9SmUyt/MSLJZxNZ7eD3?=
 =?us-ascii?Q?8Tiloyd1to6NdC6+iVuq+gpquxtXnTpXiwfponQ4ZgM1dZ5ti6EwrI5OF6AM?=
 =?us-ascii?Q?qFeKfK75a7cnVxRFKEZ2aSqj2eccY9sYfP8xMGN8OB0QI+TFUhDiZt3kaJi6?=
 =?us-ascii?Q?N15Upv/PicnvG4rhF7fKvOY0BDBMEjYnMejS3pmcfndWs07G2qU4waTAwQIq?=
 =?us-ascii?Q?qz8Yp2QRxzbJJEUWS9W11M0NhpsOd9/aSrt1L/zmPPmLpyYM0I37r/ZfTMYP?=
 =?us-ascii?Q?Saa5WngJwExWEKNFX3At5jimclICK1h2OUOSHeIv1gfL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c60d68b-bc67-4281-65f8-08dc4ebecafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 00:34:13.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0byAGYYVauA5V2yzUSvq6VUkicYR4Kb1I1rVinwIbtsX504BoNDghflh+O55roSSQP2RXcvZxmLBssaEgqrhcvXoVt20Yg0PHGb5Wiqedg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1130

Hi, I see this v3 patch has been marked "Changes Requested".
Is there any part to be further modified?
Thanks.

