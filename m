Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D13152E5
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBIPgo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 10:36:44 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52764 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhBIPgm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 10:36:42 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A036F40486;
        Tue,  9 Feb 2021 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612884940; bh=YrtzXSptYOTP5/bsQW/JtBu9/TYkOVwKmDD0TYQFk+8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=elgnzlaelmvWPljvpK+YlUQCnFezd1MX0XpfvvhdSc2hGyp6U5uBMh0/4BdZiqbrI
         6OTzRdCWWBU8+My5lrHbEiQh6YJiDyejzCzg8uy/bxZGYDFqn75WCg2uOz6Ck8Bj3M
         hFe20bVcMP9qdtLCmzLK6tv5EXxanzmznjqIEaS3vhuhrRlh5fS4c9jO4UdgCF2K0j
         nC9OE+KhJ54txAduHoiKMZGAOh4pKm2J1/7/MO7fNG0U+HFspLtPLHZEReTVTJglfQ
         n7uzVAGwrxXO+kWgp1rPYw9UPINTRml/EqY04VD6j8DTlyIxtP47gdOVlUQpnofrCq
         DrvWpsiRUQDeA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 82C0FA005F;
        Tue,  9 Feb 2021 15:35:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2D909400E7;
        Tue,  9 Feb 2021 15:35:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vD/RkKSS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atYLBKRSI645LwXSWjeN3TINM/rRlN/If9bIeCY3VS1WIREUxXZUgps8nTP+spFAjLXiLhLBAk9mGT3juU7B31wkNATadF+wieY+ZY0VlsBi18PtQOeRlX7o+8Eh9SNXih0/3sc/kM3KO5aumi0cy0sWtrBFA3K5OolNlrMzBUdOJpFb2BWvZuTTIuznJEYabLdxqZv31FVk771w46BPa3IQ9s64dyMFLf8t5jipUzfNRGH7p1kXx4ylFUcJPVCH5MwuOAv11QCItlB6YVFGbTggnYEe/a6Y5QOEJCreAdoBqh7U4DehUZHyqdXjyi2OEWdwa0lztK8XjqJ9YYSIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u40pzpK48oojZYSeA8/xwY7MY3jf6O9AD8i+4xYPWl0=;
 b=WQwKcpLQ+LUvYmOC6k6bfxZgNE+4zy2CSmFiHuG7TmJXn8Sbh7DVgOBn5h8LyXvLHxmRH2EFcVDQFec+3dPQZLgh/bCjldHj/UzPk+MfeFDgvXJWxUqThU9btFpv9LKTqlBjjollv5fm+Ub7q3affGH4HZfSaAvNdIzqWjBatqyfOQ+XLKCF7aPD3tRSsf3tPqus+P0E3WD2lkHpDFU2pZ8clJ7FFAvPwfx86n6s0qu9mwdihsDISL01vHZbKEB/4/65VRoAfaMSSumrRtU2OtMPMTx/6hmTkUSJLR8n7aYm/krYhoi/gR/Y0EXdYBwul4y+/qdfmodvNM66ypmyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u40pzpK48oojZYSeA8/xwY7MY3jf6O9AD8i+4xYPWl0=;
 b=vD/RkKSSyJcYk3l1HrtqDwS7XYSl1e/9ULhjp149fPefazr2H2Do02Hs+BebkV4ReADRFyHJZP3ibQ4MeLJbrKdtehy3m00gtvBumYTrxOod0GQLxMOiJEZpUZw3p9PoAJ6u3Pd0y9NU736ghYWRnw689dhQKYBdraAnrL+vg9o=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.30; Tue, 9 Feb 2021 15:35:38 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:35:38 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH v4 15/15] dmaengine: dw-edma: Add pcim_iomap_table return
 checker
Thread-Topic: [PATCH v4 15/15] dmaengine: dw-edma: Add pcim_iomap_table return
 checker
Thread-Index: AQHW+ne0QjsvM6EPsEimlJcZEKh+JapOrh4AgAFNYIA=
Date:   Tue, 9 Feb 2021 15:35:38 +0000
Message-ID: <DM5PR12MB1835A960892E401D50DEBB9DDA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <ceb5eb396e417f9e45d39fd5ef565ba77aae6a63.1612389406.git.gustavo.pimentel@synopsys.com>
 <20210208193516.GA406304@bjorn-Precision-5520>
In-Reply-To: <20210208193516.GA406304@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLTczOThkZjEzLTZhZWMtMTFlYi05OGU2LW?=
 =?iso-8859-2?Q?Y4OTRjMjczODA0MlxhbWUtdGVzdFw3Mzk4ZGYxNC02YWVjLTExZWItOThl?=
 =?iso-8859-2?Q?Ni1mODk0YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM4MTMiIHQ9IjEzMjU3Mz?=
 =?iso-8859-2?Q?U4NTM2Mzg1ODMwMCIgaD0iMzZCdE9naVppbEJkVGJvZlRSUjRNNzJka2RF?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBQlFKQUFCOGN6WTIrZjdXQWRZbzVBQmFaVFZIMWlqa0FGcGxOVWNP?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFKNEFBQUJtQUdrQWJnQmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2?=
 =?iso-8859-2?Q?tBYmdCbkFGOEFkd0JoQUhRQVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-2?Q?FHWUFid0IxQUc0QVpBQnlBSGtBWHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1B?=
 =?iso-8859-2?Q?WHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWmdCdkFI?=
 =?iso-8859-2?Q?VUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0JsQUhJQWN3QmZBSE1BWV?=
 =?iso-8859-2?Q?FCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhBZFFCdUFHUU?=
 =?iso-8859-2?Q?FjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhBRzBBY3dC?=
 =?iso-8859-2?Q?MUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?iso-8859-2?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUU?=
 =?iso-8859-2?Q?J5QUhRQWJnQmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQU?=
 =?iso-8859-2?Q?FBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1?=
 =?iso-8859-2?Q?QUdVQWNnQnpBRjhBZEFCekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?iso-8859-2?Q?QUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QU?=
 =?iso-8859-2?Q?hNQVh3QjFBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVp3Qj?=
 =?iso-8859-2?Q?BBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhBZEFCeUFHRUFhUUJ1QUdr?=
 =?iso-8859-2?Q?QWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdFQWJBQmxB?=
 =?iso-8859-2?Q?SE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFiZ0FBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZBSE?=
 =?iso-8859-2?Q?VBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VB?=
 =?iso-8859-2?Q?YmdCekFHVUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?SUFBQUFBQUo0QUFBQnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWl?=
 =?iso-8859-2?Q?FCZkFIUUFaUUJ5QUcwQVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQU?=
 =?iso-8859-2?Q?FuZ0FBQUhZQVp3QmZBR3NBWlFCNUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFBPSIvPjwv?=
 =?iso-8859-2?Q?bWV0YT4=3D?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac4325c7-6fe6-4cac-cb87-08d8cd1059dd
x-ms-traffictypediagnostic: DM6PR12MB3371:
x-microsoft-antispam-prvs: <DM6PR12MB337151A7DFD20FD4EE1A5EBDDA8E9@DM6PR12MB3371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkj+Kkmtd/j2h9hcH/0WHnUXNRDhim/Sg0ZFCrw+mI47lRstrt/KUj/MFqhgQ2dxMtfbz3o9XTIOJZqhQMufHVkl4P3Xnz6Q8JN/EB4EKgSUHS+A8JJkLkQf9UcvOTKEq09vBwncTh8QoW5KkbKHVDb7Pr1r36yr1HlZXUYQa9XujCnqy0QpuEfIPKEGgN0OFo+KmhMMsy6EjI55H2BEA+8hrwJ698HBn+Ydo8L6Cu/D8ui+O79nPncWyX9vd4jly90obwpMDoNPJhhPS7cwdSO5DmikJJKLJ82s4vP0JBMX2jSvYuXKC60dWLsu3BM8oLcoryiJ9xQKtv5s0GUNG0GAQjegdbNq/kqwV2iVNbr8azbM2uSOERaESNmFQWyqidI8NZuwm3062OQ1IWrDsN3F2IZ/LIBB+wdf2WQdW0H1rvIjB9m0v6WVDZGs19CKCL3xItsxyUQlbXDr2LNpM0Om4K+X0R4ov42ysIpx0+o/kjeevPu9gndlUWKhCGSbqq3QTV/K4jNMYWNs64bL/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(366004)(346002)(478600001)(64756008)(66476007)(66446008)(66556008)(66946007)(55016002)(9686003)(76116006)(54906003)(8676002)(4326008)(316002)(71200400001)(8936002)(83380400001)(7696005)(6506007)(53546011)(86362001)(2906002)(5660300002)(6916009)(52536014)(33656002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?0vvFR3FY3NFnk7tBRULGnHBlSu05sfxknWwMIHTobiLjog86H6BXo4vs/Z?=
 =?iso-8859-2?Q?K1p3MCjqhAAnKVxna+zwYjKbuqInlIC9J6UX87PDfJADxMvKPpPbKJ5mar?=
 =?iso-8859-2?Q?6cmzRDlOgd08y1NOcXRCBOKTfiHbg/LSjAqZNi2KHIkb+mpk6X+zzqfyTq?=
 =?iso-8859-2?Q?r5fGtahlLANYmOAG8KMoWfS3MlpmIGhkigUbgCHw7m7xZz/K1lUnjgs8LA?=
 =?iso-8859-2?Q?mZcv2KVbNX3GsrG/sHcg8oXe29S6sO3rMI9bi0wgHIVZZjJV3VaK/ztScr?=
 =?iso-8859-2?Q?GdziKRJRNuBOfFXN+iIRO+M6f9ElmmqMIMS6DEtkC/ppfihrYw8W34WbhA?=
 =?iso-8859-2?Q?z3dUgDw6LCe3fn0EwSn8OAf3R1Ikd3zsQ/+OnVSeAJWuHtFOXjJmJ3ChEJ?=
 =?iso-8859-2?Q?TKoCxAVg6N0uwzIO9lqtrTKgCvuVyqd9nKXBzztqxLTS++Xt6obCghymYO?=
 =?iso-8859-2?Q?h+7NQPCx6CIr9R1QjorbFJOa8Wb9mNL1BA0ju4ImxRijnhPPLB+ldjXEpb?=
 =?iso-8859-2?Q?/qHZPwlZMk1AaYSuIArfU7aQhoN209h3z+VJoySehLTg7ebYXW0fv2PMDr?=
 =?iso-8859-2?Q?kyZTi9lTSK4W4ctx0aH9xBwC3p99pJ0SBvsbqn/pPThdrHj4/V2mlV+479?=
 =?iso-8859-2?Q?s6uUx9mTVIcR1uU4VdYFJBWCJygNhR1rrIGQslr+eDF7EKqH7hXgLj/VTt?=
 =?iso-8859-2?Q?xAyOLhlMQneiyCbjcHzIg+v09Q+PNtpYXCF+5K31BoC1zdoYJ5pHTEpUEH?=
 =?iso-8859-2?Q?ACE2u/xnkN5Q5N14BWQcNwaeQBCl5UHANbh9nuAkzKkLsil7e7SToXcnBK?=
 =?iso-8859-2?Q?SeWQ3lZw8X8oi5Wi5bl8NPVp5jP/rZjau89eNkGeQeEsOoZ+iodb/Rlxs+?=
 =?iso-8859-2?Q?SzQcuVbvC2ryDB+KydenYqltNEpSEAutBuFzWLcZQrc+0LJYZGf8vLqlOi?=
 =?iso-8859-2?Q?pBZcnrq3J+cJ1Pby5506Gbko87W40MUzEnz+mkwD38k1Rlk1zKsw9umA3Z?=
 =?iso-8859-2?Q?cYrK+CBTmPSY1we/kNLr08ZOZEyX2kHYLOPpfVrG6CSo7IKH/4mpBObjcz?=
 =?iso-8859-2?Q?a0aVF1QOARa2bBq7EDTbSjIOzfBR3BOD8l+tOl4eFCTQb9IHpXX7OHQAt/?=
 =?iso-8859-2?Q?q6vJxAi1Eusd558Gm+HOAGLkORC5UFIFnSkjwc/aA2N77blUY+U053A3L3?=
 =?iso-8859-2?Q?blVA26daMOv2QyIavFS26GnoMIjTSagfd14UszegXWji4U5wS9SoBGwdCP?=
 =?iso-8859-2?Q?gS0XgbptCik/1Jx3EvkvoENGQqGmmm9lisgbYnJ+YrfBZIw2PVeXPf+hwu?=
 =?iso-8859-2?Q?UAVw8A08k5kwrYNdTqpfb7b5vpJBe2Bv51hRgeuow/czFds=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4325c7-6fe6-4cac-cb87-08d8cd1059dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:35:38.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EBV8CiMR2kEPjt+bkDSHUSo4cD1KY0p/EOkb9adfDDQiFaIWbrdm7zmGqwzapaVUY7I5r4zOZQur/W1GtCL6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 8, 2021 at 19:35:16, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> [+cc Krzysztof]
>=20
> From reading the subject, I thought you were adding a function to
> check the return values, i.e., a "checker."  But you're really adding
> "checks" :)

That's true, I will rework the subject.

>=20
> On Wed, Feb 03, 2021 at 10:58:06PM +0100, Gustavo Pimentel wrote:
> > Detected by CoverityScan CID 16555 ("Dereference null return")
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/d=
w-edma-pcie.c
> > index 686b4ff..7445033 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -238,6 +238,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	dw->rd_ch_cnt =3D vsec_data.rd_ch_cnt;
> > =20
> >  	dw->rg_region.vaddr =3D pcim_iomap_table(pdev)[vsec_data.rg.bar];
> > +	if (!dw->rg_region.vaddr)
> > +		return -ENOMEM;
>=20
> This doesn't seem quite right.  If pcim_iomap_table() fails, it
> returns NULL.  But then we assign "vaddr =3D NULL[vsec_data.rg.bar]"
> which dereferences the NULL pointer even before your test.

I'll add verification of the pointer given by pcim_iomap_table(pdev)=20
first.

>=20
> This "pcim_iomap_table(dev)[n]" pattern is extremely common.  There
> are over 100 calls of pcim_iomap_table(), and
>=20
>   $ git grep "pcim_iomap_table(.*)\[.*\]" | wc -l
>=20
> says about 75 of them are of this form, where we dereference the
> result before testing it.

That's true, there are a lot of drivers that don't verify that pointer.=20
What do you suggest?
1) To remove the verification so that is aligned with the other drivers
2) Leave it as is. Or even to add this verification to the other drivers?

Either way, I will add the pcim_iomap_table(pdev) before this=20
instruction.

>=20
> >  	dw->rg_region.vaddr +=3D vsec_data.rg.off;
> >  	dw->rg_region.paddr =3D pdev->resource[vsec_data.rg.bar].start;
> >  	dw->rg_region.paddr +=3D vsec_data.rg.off;
> > @@ -250,12 +253,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pde=
v,
> >  		struct dw_edma_block *dt_block =3D &vsec_data.dt_wr[i];
> > =20
> >  		ll_region->vaddr =3D pcim_iomap_table(pdev)[ll_block->bar];
> > +		if (!ll_region->vaddr)
> > +			return -ENOMEM;
> > +
> >  		ll_region->vaddr +=3D ll_block->off;
> >  		ll_region->paddr =3D pdev->resource[ll_block->bar].start;
> >  		ll_region->paddr +=3D ll_block->off;
> >  		ll_region->sz =3D ll_block->sz;
> > =20
> >  		dt_region->vaddr =3D pcim_iomap_table(pdev)[dt_block->bar];
> > +		if (!dt_region->vaddr)
> > +			return -ENOMEM;
> > +
> >  		dt_region->vaddr +=3D dt_block->off;
> >  		dt_region->paddr =3D pdev->resource[dt_block->bar].start;
> >  		dt_region->paddr +=3D dt_block->off;
> > @@ -269,12 +278,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pde=
v,
> >  		struct dw_edma_block *dt_block =3D &vsec_data.dt_rd[i];
> > =20
> >  		ll_region->vaddr =3D pcim_iomap_table(pdev)[ll_block->bar];
> > +		if (!ll_region->vaddr)
> > +			return -ENOMEM;
> > +
> >  		ll_region->vaddr +=3D ll_block->off;
> >  		ll_region->paddr =3D pdev->resource[ll_block->bar].start;
> >  		ll_region->paddr +=3D ll_block->off;
> >  		ll_region->sz =3D ll_block->sz;
> > =20
> >  		dt_region->vaddr =3D pcim_iomap_table(pdev)[dt_block->bar];
> > +		if (!dt_region->vaddr)
> > +			return -ENOMEM;
> > +
> >  		dt_region->vaddr +=3D dt_block->off;
> >  		dt_region->paddr =3D pdev->resource[dt_block->bar].start;
> >  		dt_region->paddr +=3D dt_block->off;
> > --=20
> > 2.7.4
> >=20


